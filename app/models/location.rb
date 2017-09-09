class Location < ApplicationRecord
  has_many :drafts, as: :record
  # Inherit from this class to setup locations for an organization's google sheet
  # You need to setup the class methods:
  # - config,
  # - filters (one per filter)
  # - legacy_field (one per table column)
  #
  # See below for how to use.

  # Columns included in table and updates by default. They live on the locations table.
  DefaultColumns = %i(name address city state zip phone)
  Field = Struct.new(:name, :type, :options, :required) do
    def description
      case type
      when :string
        "A string column. Returns text."
      when :phone
        "A phone numbers. Returns text. May include - ( )"
      when :zip
        "A zip code. Returns text. May include - for zip+4"
      when :boolean
        "A boolean column. Returns boolean"
      when :enum
        "A enum column. Returns text limited to the values specified in options above"
      end
    end
  end
  Filter = Struct.new(:name, :type, :column) do
    def description
      case type
      when :string
        "Searches the specified column for the supplied value, case insensitive"
      when :coordinates
        "expects 2 values: lng and lat, returns results within 100 miles sorted by distance ascending"
      when :limit
        "returns up to the limit results"
      when :truthy
        "for boolean columns, returns all results that are true"
      end
    end
  end

  # All children pull from the locations table. This is handle rolled single table
  # inheritence.
  self.table_name = "locations"

  geocoded_by :full_address
  after_validation :geocode, if: ->(obj){ obj.full_address.present? and obj.geocode_address? }

  def full_address
    [address, city, state, zip].compact.join(', ')
  end

  def geocode_address?
    changed = address_changed? || city_changed? || state_changed? || zip_changed?
    geocodable = [address, city, state, zip].map(&:present?).all?

    changed && geocodable
  end

  class << self
    # columns is used by active record, so we prefix it with table otherwise
    # nothing works
    attr_reader(
      :api_help,
      :legacy_table_name,
      :legacy_table_display_name,
      :organization,
      :organization_display_name,
      :filters,
      :legacy_data,
      :table_columns,
      :table_headers,
      :legacy_headers,
      :update_fields,
      :admin_columns,
      :admin_headers,
      :admin_legacy_headers,
    )

    # Set Config
    # You also need to add new classes to Location::Whitelist::Locations or the controllers won't be able to find
    # the child class.
    # - organization: string, lower case, hyphenated, name for the organization, used for the brand in the navbar
    # - legacy_table_name: string, lower case, hyphenated, name displayed in navbar (Shelters, Needs, etc)
    def config(organization:, legacy_table_name:)
      name = Field.new(:name, :string, [], true)
      address = Field.new(:address, :string, [], true)
      city = Field.new(:city, :string, [], true)
      state = Field.new(:state, :string, [], true)
      zip = Field.new(:zip, :zip, [], true)
      phone = Field.new(:phone, :phone, [], false)
      lat = Field.new(:latitude, :float, [], false)
      lon = Field.new(:longitude, :float, [], false)

      @legacy_table_name = legacy_table_name
      @legacy_table_display_name = legacy_table_name.titleize
      @organization = organization
      @organization_display_name = organization.titleize

      default_scope { where(active: !false, organization: organization, legacy_table_name: legacy_table_name) }

      @table_columns ||= [].concat(DefaultColumns)
      @table_headers ||= DefaultColumns.map(&:to_s).map(&:titleize)
      @legacy_headers ||= DefaultColumns.map(&:to_s).map(&:titleize)
      @update_fields ||= [name, address, city, state, zip, phone]
      @admin_columns ||= []
      @admin_headers ||= []
      @admin_legacy_headers ||= []
      @api_help ||= [name, address, city, state, zip, phone, lat, lon]
    end

    # API filters.
    # Filter for coordinates built in if model has a longitude and latitude field set on record, not fields.
    # Filter for limit built in.
    # The column field on Filter is whether or not the name is a default column. If false, this tells the filter
    # to search inside the legacy_data JSONb
    # - name: symbol, the name of the filter, correspondes to the query param (except for coordinates)
    # - type: symbol, one of (note: zip and phone types are searched as text)
    #   - :string searches in column for matching string
    #   - :truthy searches in column for true values
    def filter(name, type: :string)
      @filters ||= {}
      column = DefaultColumns.include?(name)

      case name
      when :coordinates
        @filters[name] = Filter.new(name, :coordinates, nil)
      when :limit
        @filters[name] = Filter.new(name, :limit, nil)
      else
        @filters[name] = Filter.new(name, type, column)
      end
    end

    # Legacy Fields to import from the google sheet and display on tables and forms
    # You must run the config function before this one or the class variables will
    # not be setup.
    # name: symbol, name of the column in database json field
    # type: symbol, valid values are:
    # - :string
    # - :boolean, looks for true/false and yes/no, blanks are preserved as nil
    # - :enum, looks for true/false and yes/no, blanks are preserved as nil
    # column: string, the name of the column in the google sheet.
    # display: boolean, whether to display the field in the table and show pages, default true
    # updatable: boolean, whether to display the field in the form, default true
    # admin_only: boolean, if true only admins may view the data, if set to true overrides display
    # options: fields for enum
    def legacy_field(name, type: :string, legacy_column: nil, display: true, updatable: true, admin_only: false, options: [], required: false)
      legacy_column ||= name.to_s.titleize
      field = Field.new(name, type, options, required)

      # Set information for the table columns and api help
      if(display && !admin_only)
        @table_columns.push(name)
        @table_headers.push(name.to_s.titleize)
        @legacy_headers.push(legacy_column)
        @api_help.push(field)
      end

      # Set which fields can be updated
      if(updatable)
        @update_fields.push(field)
      end

      # Set which fields are viewable by admins only
      if(admin_only)
        @admin_columns.push(name)
        @admin_headers.push(name.to_s.titleize)
        @admin_legacy_headers.push(legacy_column)
      end


      # Setup getter and setter for field
      define_method(name) do
        legacy_data[name.to_s]
      end
      define_method(name.to_s+'=') do |value|
        # TODO support coersion for more types, problematic bc it could raise errors
        legacy_data[name.to_s] = self.class.format_field(type, value, options)
      end
    end

    def format_field(type, value, options=[])
      case type
      when :boolean
        ((value == true) || /(yes|true|t|1|y)/.match?(value.to_s)) ? true : false
      when :enum
        options.include?(value) ? value : nil
      when :phone
        # Leave in dashes and parens for phone numbers
        value.gsub(/[^\d()-]/, "")
      when :zip
        # Leave in dashes for zip+4
        value.gsub(/[^\d-]/, "")
      else
        value
      end
    end
    # Field sets up a relationship between the legacy column and the location columns
    # Useful when longitude/latitude already geocoded, mapping names, phone numbers,
    # and other 'clean' data.
    # - column: symbol, name of the column to map to on location
    # - legacy_column_name: string, name of the column on the legacy table
    def field(column, legacy_column_name)
    end

    def legacy_data
      super.with_indifferent_access
    end
  end
end

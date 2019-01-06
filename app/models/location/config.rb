class Location
  class Config
    attr_reader(
      :legacy_table_name,
      :legacy_table_display_name,
      :organization,
      :organization_display_name,
      :filters,
      :legacy_data,
      :columns,
      :headers,
      :legacy_headers,
      :update_fields,
      :admin_columns,
      :admin_headers,
      :admin_legacy_headers
    )

    # Set Config
    # - display_name: name displayed in navbar (Shelters, Needs, etc)
    # - organization: slug for the organization, will probably be used for the brand in the navbar
    def config(organization:, legacy_table_name:)
      @legacy_table_name = legacy_table_name
      @legacy_table_display_name = legacy_table_name.titleize
      @organization = organization
      @organization_display_name = organization.titleize

      @@children ||= {}.with_indifferent_access
      @@children[organization] ||= {}.with_indifferent_access
      @@children[organization][legacy_table_name] ||= self
    end

    # API filters.
    # Filter for coordinates built in if model has a longitude and latitude field set on record, not fields
    # Filter for limit built in
    # Customer filters:
    # - :string searches in column for matching string
    # - :boolean searches in column for true values
    Filter = Struct.new(:type)
    def filter(name, type: :string)
      @filters ||= {}

      @filters[name] = case name
                       when :coordinates
                         Filter.new(:coordinates)
                       when :limit
                         Filter.new(:limit)
                       else
                         Filter.new(type)
                       end
    end

    # Legacy Fields to import from the google sheet
    # name: symbol, name of the column in database json field
    # type: symbol, valid values are:
    # - :string
    # - :boolean, looks for true/false and yes/no, blanks are preserved as nil
    # column: string, the name of the column in the google sheet.
    # display: boolean, whether to display the field in the table and show pages, default true
    # updatable: boolean, whether to display the field in the form, default true
    # admin_only: boolean, if true only admins may view the data, if set to true overrides display
    def legacy_field(name, type: :string, legacy_column: nil, display: true, updatable: true, admin_only: false)
      legacy_column ||= name.to_s.titleize

      # Set information for the columns
      if display && !admin_only
        @columns ||= []
        @columns.push(name)
        @headers ||= []
        @headers.push(name.to_s.titleize)
        @legacy_headers ||= []
        @legacy_headers.push(legacy_column)
      end

      # Set which fields can be updated
      if updatable
        @update_fields ||= []
        @update_fields.push(name)
      end

      # Set which fields are viewable by admins only
      if admin_only
        @admin_columns ||= []
        @admin_columns.push(name)
        @admin_headers ||= []
        @admin_headers.push(name.to_s.titleize)
        @admin_legacy_headers ||= []
        @admin_legacy_headers.push(legacy_column)
      end

      define_method(name) do
        legacy_data[name.to_s]
      end
      define_method(name.to_s + '=') do |value|
        value =
          case type
          when :boolean
            (value == true) || /(yes|true|t|1|y)/.match?(value) ? true : false
          else
            value
          end
        legacy_data[name.to_s] = value
      end
    end

    # Field sets up a relationship between the legacy column and the location columns
    # Useful when longitude/latitude already geocoded, mapping names, phone numbers,
    # and other 'clean' data.
    # - column: symbol, name of the column to map to on location
    # - legacy_column_name: string, name of the column on the legacy table
    def field(column, legacy_column_name); end
  end
end

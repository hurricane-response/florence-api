module Geocodable
  extend ActiveSupport::Concern

  #
  # Geocoable Concern
  #
  # Adds geocoding to the model so that it can be managed appropriately.
  #
  # Requires the model to have database fields / columns:
  #   latitude, longitude, address, city, state, zip, county

  included do
    after_commit :schedule_reverse_geocode

    scope :incomplete_geocoding, -> { where(<<~SQL
      county IS NULL OR TRIM(county) = '' OR
      city IS NULL OR TRIM(city) = '' OR
      state IS NULL OR TRIM(state) = '' OR
      zip IS NULL OR TRIM(zip) = ''
      SQL
    ) }

    geocoded_by :address
    reverse_geocoded_by(:latitude, :longitude) do |obj, result|
      geo = result.first
      if geo
        county = geo.data['address_components'].find { |el| el['types'].include?('administrative_area_level_2') }
        obj.county = county.fetch('long_name', '') unless obj.county.nil?
        obj.address = geo.data['formatted_address']
        obj.city = geo.city if obj.city.blank?
        obj.state = geo.state if obj.state.blank?
        obj.zip = geo.postal_code if obj.zip.blank?
      end
      obj
    end
  end

  class_methods do
    def geo_recode(*ids)
      list = ids.empty? ? incomplete_geocoding : where(id: ids)
      list.each do |obj|
        obj.recode_geofields
        obj.save
        sleep(0.1) # REVIEW: Is this unnecessary?
      end
    end
  end

  def reverse_geocode_needed?
    county.blank? || city.blank? || zip.blank? || state.blank?
  end

  def recode_geofields(force = false)
    reverse_geocode if force || reverse_geocode_needed?
  end

  def recode_geofields!(force = false)
    recode_geofields(force)
    save if changed?
  end

  def schedule_reverse_geocode
    RecodeGeocodingJob.perform_later('Shelter', self.id) if reverse_geocode_needed?
  end
end

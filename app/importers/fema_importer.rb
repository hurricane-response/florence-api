require 'rubygems'
require 'httparty'

class FemaImporter
  include HTTParty
  base_uri 'https://gis.fema.gov/geoserver/FEMA'
  format :json

  QueryValues = {
    'service' => 'WFS',
    'version' => '1.0.0',
    'request' => ' GetFeature',
    'typeName' => 'FEMA:FEMANSSOpenShelters',
    'maxFeatures' => 250,
    'outputFormat' => 'json'
  }.freeze

  def self.shelters
    fema_data = get('/ows', query: QueryValues)
    fema_data['features'].map do |f|
      props = f['properties']
      status = props['SHELTER_STATUS'].upcase
      max_population = props['EVACUATION_CAPACITY'].to_i
      cur_population = props['TOTAL_POPULATION'].to_i
      accepting =
        if status == 'CLOSED'
          :no
        elsif status == 'STANDBY' || !max_population.positive? || cur_population.negative?
          :unknown
        elsif cur_population >= max_population
          :no
        else
          :yes
        end

      data = {
        longitude: f['geometry']['coordinates'][0],
        latitude: f['geometry']['coordinates'][1],
        shelter: props['SHELTER_NAME'],
        address: "#{props['ADDRESS']}, #{props['CITY']}, #{props['STATE']} #{props['ZIP']}",
        city: props['CITY'],
        state: props['STATE'],
        zip: props['ZIP'],

        # If not closed, the sheter will likely have staff available to answer Questions
        # if shelter-seekers do show up even if they are not accepting at this time.
        active: status != 'CLOSED',
        accepting: accepting
      }

      data[:source] = 'FEMA GeoServer'
      data[:source] << ", Shelter ID: #{props['SHELTER_ID']}" unless props['SHELTER_ID'].blank?
      data[:source] << ", Org ID: #{props['ORG_ID']}" unless props['ORG_ID'].blank?
      data[:source] << ", #{props['ORG_NAME']}" unless props['ORG_NAME'].blank?

      data[:private_notes] = <<~NOTE
        Capacity: #{props['TOTAL_POPULATION']} / #{props['EVACUATION_CAPACITY']} (#{props['POST_IMPACT_CAPACITY']})
      NOTE
      unless props['HOURS_OPEN'].blank? && props['HOURS_CLOSE'].blank?
        data[:notes] = "\nHours: #{props['HOURS_OPEN']} to #{props['HOURS_CLOSE']}"
      end

      data
    end
  end
end

require 'rubygems'
require 'httparty'

class FemaImporter
  include HTTParty
  base_uri 'https://gis.fema.gov/geoserver/FEMA'
  format :json

  QueryValues = {
    'service' => 'WFS',
    'version' => '1.0.0',
    'request' =>' GetFeature',
    'typeName' => 'FEMA:FEMANSSOpenShelters',
    'maxFeatures' => 250,
    'outputFormat' => 'json'
  }.freeze


  def self.shelters
    fema_data = get('/ows', query: QueryValues)
    fema_data['features'].map do |f|
      props = f['properties']
      data = {
        longitude: f['geometry']['coordinates'][0],
        latitude: f['geometry']['coordinates'][1],
        source: "FEMA GeoServer, Shelter ID: #{props['SHELTER_ID']}, Org ID: #{props['ORG_ID']}, #{props['ORG_NAME']}",
        shelter: props['SHELTER_NAME'],
        address: "#{props['ADDRESS']}, #{props['CITY']}, #{props['STATE']} #{props['ZIP']}",
        city: props['CITY'],
        state: props['STATE'],
        zip: props['ZIP'],
        active: props['SHELTER_STATUS'] == 'OPEN' ? :yes : :no
      } 

      data['notes'] = <<~NOTE
        Capacity: #{props['TOTAL_POPULATION']} / #{props['EVACUATION_CAPACITY']} (#{props['POST_IMPACT_CAPACITY']})
      NOTE
      if props['HOURS_OPEN'] || props['HOURS_CLOSE']
        data['notes'] << "\nHours: #{props['HOURS_OPEN']} to #{ props['HOURS_CLOSE']}"
      end
      data
    end
  end
end

require 'test_helper'

class Api::SheltersControllerTest < ActionDispatch::IntegrationTest
  test 'index returns all shelters' do
    count = Shelter.count
    get '/api/v1/shelters'
    json = JSON.parse(response.body)
    assert_equal count, json['shelters'].length
    assert_equal count, json['meta']['result_count']
  end

  test 'filters are returned' do
    count = Shelter.where(accepting: :yes).count
    get '/api/v1/shelters?accepting=yes'
    json = JSON.parse(response.body)
    assert_equal count, json['shelters'].length
    assert_equal count, json['meta']['result_count']
    assert_equal 'yes', json['meta']['filters']['accepting']
  end
  test 'accepting filter supports true as well as yes' do
    count = Shelter.where(accepting: :yes).count
    get '/api/v1/shelters?accepting=true'
    json = JSON.parse(response.body)
    assert_equal count, json['shelters'].length
    assert_equal count, json['meta']['result_count']
    assert_equal 'yes', json['meta']['filters']['accepting']
  end

  test 'shelters are not returned after they are archived' do
    archived = Shelter.where(archived: true).count
    active = Shelter.count
    count = active - archived
    get '/api/v1/shelters'
    json = JSON.parse(response.body)
    assert_equal count, json['shelters'].length
  end

  test 'geo returns valid geojson' do
    get '/api/v1/shelters/geo'
    json = JSON.parse(response.body)
    assert_equal json['type'], 'FeatureCollection'
    assert_instance_of Array, json['features']
    assert_equal json['features'][0]['type'], 'Feature'
    assert_includes json['features'][0].keys, 'properties'
    assert_includes json['features'][0].keys, 'geometry'
    assert_equal json['features'][0]['geometry']['type'], 'Point'
    assert_includes json['features'][0]['geometry'].keys, 'coordinates'
    assert_instance_of Array, json['features'][0]['geometry']['coordinates']
  end

  test 'geo returns all shelters' do
    count = Shelter.count
    get '/api/v1/shelters/geo'
    json = JSON.parse(response.body)
    assert_equal count, json['features'].length
  end

  test 'returned features serials with correct pets allowed value' do
    pets_values = %w[Yes No Unknown].freeze

    get '/api/v1/shelters'
    json = JSON.parse(response.body)
    json['shelters'].each do |shelter|
      assert pets_values.include?(shelter['pets'])
    end
  end
end

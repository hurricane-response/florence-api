require 'test_helper'

class Api::DistributionPointsControllerTest < ActionDispatch::IntegrationTest

  test 'returns all points of distribution' do
    count = DistributionPoint.count
    get '/api/v1/distribution_points'
    json = JSON.parse(response.body)
    assert_equal count, json['distribution_points'].length
    assert_equal count, json['meta']['result_count']
  end

  test 'filters are returned' do
    count = DistributionPoint.where(facility_name: 'facility').count
    get '/api/v1/distribution_points?name=facility'
    json = JSON.parse(response.body)
    assert_equal count, json['distribution_points'].length
    assert_equal count, json['meta']['result_count']
    assert_equal 'facility', json['meta']['filters']['name']
  end

  test 'distribution points are not returned after they are archived' do
    archived = DistributionPoint.where(archived: true).count
    active = DistributionPoint.where(archived: false).count
    count = active - archived
    get '/api/v1/distribution_points'
    json = JSON.parse(response.body)
    assert_equal count, json['distribution_points'].length
  end

  test "geo returns valid geojson" do
    get "/api/v1/distribution_points/geo"
    json = JSON.parse(response.body)
    assert_equal json["type"], "FeatureCollection"
    assert_instance_of Array, json["features"]
    assert_equal json["features"][0]["type"], "Feature"
    assert_includes json["features"][0].keys, "properties"
    assert_includes json["features"][0].keys, "geometry"
    assert_equal json["features"][0]["geometry"]["type"], "Point"
    assert_includes json["features"][0]["geometry"].keys, "coordinates"
    assert_instance_of Array, json["features"][0]["geometry"]["coordinates"]
  end

  test "geo returns all distribution points" do
    count = DistributionPoint.count
    get "/api/v1/distribution_points/geo"
    json = JSON.parse(response.body)
    assert_equal count, json["features"].length
  end
end

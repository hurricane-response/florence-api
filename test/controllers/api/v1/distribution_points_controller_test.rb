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
    archived = DistributionPoint.where(active: false).count
    active = DistributionPoint.where(active: true).count
    count = active - archived
    get '/api/v1/distribution_points'
    json = JSON.parse(response.body)
    assert_equal count, json['distribution_points'].length
  end
end

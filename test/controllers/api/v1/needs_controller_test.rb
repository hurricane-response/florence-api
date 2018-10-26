require 'test_helper'

class Api::NeedsControllerTest < ActionDispatch::IntegrationTest
  test 'returns all needs' do
    count = Need.count
    get '/api/v1/needs'
    json = JSON.parse(response.body)
    assert_equal count, json['needs'].length
    assert_equal count, json['meta']['result_count']
  end

  test 'filters are returned' do
    count = Need.where(are_supplies_needed: true).count
    get '/api/v1/needs?supplies_needed=true'
    json = JSON.parse(response.body)
    assert_equal count, json['needs'].length
    assert_equal count, json['meta']['result_count']
    assert_equal 'true', json['meta']['filters']['supplies_needed']
  end

  test 'needs are not returned after they are archived' do
    archived = Need.where(archived: true).count
    active = Need.count
    count = active - archived
    get '/api/v1/needs'
    json = JSON.parse(response.body)
    assert_equal count, json['needs'].length
  end

  test 'needs can be created via JSON api' do
    expected_count = Need.count + 1
    name = 'Example Need'
    headers = { 'Authorization': "Bearer #{ENV['JSON_API_KEY']}" }
    need_params = { location_name: name }
    post '/api/v1/needs', headers: headers, as: :json, params: need_params

    assert_response :success
    json = JSON.parse(response.body)
    assert json['meta']['success']

    assert_equal(expected_count, Need.count)
    assert_equal(name, Need.last.location_name)
  end

  test 'needs cannot be created via JSON API without providing the proper API key' do
    expected_count = Need.count
    name = 'Example Need'
    headers = { 'Authorization': "Bearer FAKE#{ENV['JSON_API_KEY']}" }
    need_params = { location_name: name }
    post '/api/v1/needs', headers: headers, as: :json, params: need_params

    assert_response :forbidden
    assert_equal expected_count, Need.count
  end
end

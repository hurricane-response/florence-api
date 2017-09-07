require 'test_helper'

class Api::V1::Connect::MarkersControllerTest < ActionDispatch::IntegrationTest

  test "returns all unresolved markers" do
    count = Connect::Marker.unresolved.count
    get api_v1_connect_markers_path
    json = JSON.parse(response.body)
    assert_equal count, json["markers"].length
    assert_equal count, json["meta"]["result_count"]
    assert json["markers"][0].key?("email")
  end

  test "can limit the number of markers returned" do
    get api_v1_connect_markers_path, params: { limit: 1 }
    json = JSON.parse(response.body)
    assert_equal 1, json["markers"].length
    assert_equal 1, json["meta"]["result_count"]
    assert_equal 1, json["meta"]["filters"]["limit"]
  end

  test "can filter markers by proximity" do
    marker = connect_markers(:have)
    filter = { lat: marker.latitude, lon: marker.longitude, rad: 2 }
    get api_v1_connect_markers_path, params: filter
    json = JSON.parse(response.body)
    assert_equal 2, json["markers"].length
  end

  test "can filter markers by category" do
    filter = { category: "shop" }
    get api_v1_connect_markers_path, params: filter
    json = JSON.parse(response.body)
    assert_equal 1, json["markers"].length
    assert_equal 'labor shop', json["markers"][0]["category"]
  end

  test "should create marker" do
    keys = %w(marker_type name description category phone latitude longitude data device_uuid)
    attribs = connect_markers(:have).attributes.slice(*keys)
    assert_difference('Connect::Marker.count') do
      post api_v1_connect_markers_path, params: { marker: attribs }
    end
    json = JSON.parse(response.body)
    assert_equal attribs["name"], json["name"]
    refute json["data"].keys.empty?
  end

  test "can update a marker" do
    marker = connect_markers(:have)
    assert_difference('Connect::Marker.unresolved.count', -1) do
      patch api_v1_connect_marker_path(marker), params: { marker: { resolved: true } }
    end
    json = JSON.parse(response.body)
    assert json["resolved"], 'marker should be marked as resolved'
  end
end

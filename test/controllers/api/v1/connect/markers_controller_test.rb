# frozen_string_literal: true

require 'test_helper'

class Api::V1::Connect::MarkersControllerTest < ActionDispatch::IntegrationTest

  def default_headers(headers = nil)
    headers || { "DisasterConnect-Device-UUID": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" }
  end

  test "returns all unresolved markers" do
    count = Connect::Marker.unresolved.count
    get api_v1_connect_markers_path, headers: default_headers
    json = JSON.parse(response.body)
    assert_equal count, json["markers"].length
    assert_equal count, json["meta"]["result_count"]
    assert json["markers"][0].key?("email")
  end

  test "can limit the number of markers returned" do
    get api_v1_connect_markers_path, params: { limit: 1 }, headers: default_headers
    json = JSON.parse(response.body)
    assert_equal 1, json["markers"].length
    assert_equal 1, json["meta"]["result_count"]
    assert_equal 1, json["meta"]["filters"]["limit"]
  end

  test "can filter markers by proximity" do
    marker = connect_markers(:have)
    filter = { lat: marker.latitude, lon: marker.longitude, rad: 2 }
    get api_v1_connect_markers_path, params: filter, headers: default_headers
    json = JSON.parse(response.body)
    assert_equal 2, json["markers"].length
  end

  test "can filter markers by category" do
    filter = { category: "labor" }
    get api_v1_connect_markers_path, params: filter, headers: default_headers
    json = JSON.parse(response.body)
    assert_equal 1, json["markers"].length
    assert json["markers"][0]["categories"].has_key?('labor')
  end

  test "can filter markers by device uuid" do
    filter = { device_uuid: "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" }
    get api_v1_connect_markers_path, params: filter, headers: default_headers
    json = JSON.parse(response.body)
    ids = json["markers"].map { |m| m["id"] }
    ::Connect::Marker.find(ids).each { |m| assert m.device_uuid == filter[:device_uuid] }
  end

  test "should create marker" do
    keys = %w(marker_type name description categories phone latitude longitude data device_uuid)
    attribs = connect_markers(:have).attributes.slice(*keys)
    assert_difference('Connect::Marker.count') do
      post api_v1_connect_markers_path, params: { marker: attribs }, headers: default_headers
    end
    json = JSON.parse(response.body)
    assert_equal attribs["name"], json["name"]
    refute json["data"].keys.empty?
  end

  test "should not create a marker without a device uuid" do
    keys = %w(marker_type name description categories phone latitude longitude data device_uuid)
    attribs = connect_markers(:have).attributes.slice(*keys)
    post api_v1_connect_markers_path, params: { marker: attribs }, headers: default_headers({})
    assert_response 403
  end

  test "can update a marker" do
    marker = connect_markers(:have)
    assert_difference('Connect::Marker.unresolved.count', -1) do
      patch api_v1_connect_marker_path(marker), params: { marker: { resolved: true } }, headers: default_headers
    end
    json = JSON.parse(response.body)
    assert json["resolved"], 'marker should be marked as resolved'
  end

  test "can not update a marker without a device uuid" do
    marker = connect_markers(:have)
    patch api_v1_connect_marker_path(marker), params: { marker: { resolved: true } }, headers: default_headers({})
    assert_response 403
  end

  test "can not update markers that you did not create" do
    marker = connect_markers(:have)
    assert_raises ActiveRecord::RecordNotFound do
      patch api_v1_connect_marker_path(marker), params: { marker: { resolved: true } }, headers: default_headers({ "DisasterConnect-Device-UUID": "threeve" })
    end
  end
end

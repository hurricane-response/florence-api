require 'test_helper'

class Api::V1::Connect::MarkersControllerTest < ActionDispatch::IntegrationTest

  test "returns all unresolved markers" do
    count = Connect::Marker.unresolved.count
    get api_v1_connect_markers_path
    json = JSON.parse(response.body)
    assert_equal count, json["markers"].length
    assert_equal count, json["meta"]["result_count"]
  end
end

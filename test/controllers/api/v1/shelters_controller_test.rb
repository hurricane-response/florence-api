require 'test_helper'

class Api::SheltersControllerTest < ActionDispatch::IntegrationTest

  test "returns all shelters" do
    count = Shelter.count
    get "/api/v1/shelters"
    json = JSON.parse(response.body)
    assert_equal count, json["shelters"].length
    assert_equal count, json["meta"]["result_count"]
  end

  test "filters are returned" do
    count = Shelter.where(accepting: true).count
    get "/api/v1/shelters?accepting=true"
    json = JSON.parse(response.body)
    assert_equal count, json["shelters"].length
    assert_equal count, json["meta"]["result_count"]
    assert_equal "true", json["meta"]["filters"]["accepting"]
  end
end

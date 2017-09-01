require 'test_helper'

class Api::NeedsControllerTest < ActionDispatch::IntegrationTest

  test "returns all needs" do
    count = Need.count
    get "/api/v1/needs"
    json = JSON.parse(response.body)
    assert_equal count, json["needs"].length
    assert_equal count, json["meta"]["result_count"]
  end

  test "filters are returned" do
    count = Need.where(are_supplies_needed: true).count
    get "/api/v1/needs?supplies_needed=true"
    json = JSON.parse(response.body)
    assert_equal count, json["needs"].length
    assert_equal count, json["meta"]["result_count"]
    assert_equal "true", json["meta"]["filters"]["supplies_needed"]
  end
end

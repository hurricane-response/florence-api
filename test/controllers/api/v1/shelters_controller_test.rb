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
    count = Shelter.where(accepting: :yes).count
    get "/api/v1/shelters?accepting=yes"
    json = JSON.parse(response.body)
    assert_equal count, json["shelters"].length
    assert_equal count, json["meta"]["result_count"]
    assert_equal "yes", json["meta"]["filters"]["accepting"]
  end
  test "accepting filter supports true as well as yes" do
    count = Shelter.where(accepting: :yes).count
    get "/api/v1/shelters?accepting=true"
    json = JSON.parse(response.body)
    assert_equal count, json["shelters"].length
    assert_equal count, json["meta"]["result_count"]
    assert_equal "yes", json["meta"]["filters"]["accepting"]
  end

  test "shelters are not returned after they are archived" do
    archived = Shelter.where(active: false).count
    active = Shelter.where(active: true).count
    count = active - archived
    get "/api/v1/shelters"
    json = JSON.parse(response.body)
    assert_equal count, json["shelters"].length
  end
end

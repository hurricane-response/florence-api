require 'test_helper'

class Api::CharitableOrganizationsControllerTest < ActionDispatch::IntegrationTest

  fixtures :all

  test "returns all charitable_organizations" do
    count = CharitableOrganization.count
    get "/api/v1/charitable_organizations"
    json = JSON.parse(response.body)
    assert_equal count, json["charitable_organizations"].length
    assert_equal count, json["meta"]["result_count"]
  end

  test "filters are returned" do
    count = CharitableOrganization.where(food_bank: true).count
    get "/api/v1/charitable_organizations?food_bank=true"
    json = JSON.parse(response.body)
    assert_equal count, json["charitable_organizations"].length
    assert_equal count, json["meta"]["result_count"]
    assert_equal "true", json["meta"]["filters"]["food_bank"]
  end

  test "charitable_organizations are not returned after they are archived" do
    archived = CharitableOrganization.where(active: false).count
    active = CharitableOrganization.where(active: true).count
    count = active - archived
    get "/api/v1/charitable_organizations"
    json = JSON.parse(response.body)
    assert_equal count, json["charitable_organizations"].length
  end
end

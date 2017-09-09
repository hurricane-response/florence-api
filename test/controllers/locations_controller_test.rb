require 'test_helper'

class LocationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  Model = Location::HHRD::Rescuees

  def build_params(data)
    {
      "location_hhrd_rescuees": data
    }
  end

  test "load index" do
    get locations_path(organization: Model.organization, legacy_table_name: Model.legacy_table_name)
    assert_response :success
  end

  test "load show" do
    get location_path(organization: Model.organization, legacy_table_name: Model.legacy_table_name, id: locations(:family_rescuees))
    assert_response :success
  end

  test "load new" do
    get new_location_path(organization: Model.organization, legacy_table_name: Model.legacy_table_name)
    assert_response :success
  end

  test "creates new location if user is admin" do
    expected_count = Model.count + 1
    name = "Example Model"
    sign_in users(:admin)
    post locations_path(organization: Model.organization, legacy_table_name: Model.legacy_table_name), params: build_params({name: name, status: "Rescued"})
    assert_response :redirect
    assert_equal(expected_count, Model.count)
    assert_equal(name, Model.last.name)
    assert_equal("Rescued", Model.last.status)
  end

  test "creates new draft if user is guest creating a location" do
    expected_locations = Model.count
    expected_drafts = Draft.count + 1
    name = "Example Model"
    sign_in users(:guest)
    post locations_path(organization: Model.organization, legacy_table_name: Model.legacy_table_name), params: build_params({name: name, status: "Rescued"})
    assert_response :redirect
    assert_equal(expected_locations, Model.count)
    assert_equal(expected_drafts, Draft.count)
    assert_equal(name, Draft.last.info["name"])
    assert_equal("Rescued", Draft.last.info["status"])
  end

  test "loads edit" do
    get edit_location_path(organization: Model.organization, legacy_table_name: Model.legacy_table_name, id: locations(:family_rescuees))
    assert_response :success
  end

  test "updates if user admin" do
    location = Model.find(locations(:family_rescuees).id)
    name = "Some random name you should never name a location"
    expected_count = Model.count
    sign_in users(:admin)
    put location_path(organization: Model.organization, legacy_table_name: Model.legacy_table_name, id: location.id), params: build_params({name: name, status: "Rescued"})
    location.reload
    assert_response :redirect
    assert_equal(expected_count, Model.count)
    assert_equal(name, location.name)
    assert_equal("Rescued", location.status)
  end

  test "creates new draft if user is guest updating a location" do
    location = locations(:family_rescuees)
    location_name = location.name
    draft_name = "Some random name you should never name a location"
    expected_locations = Model.count
    expected_drafts = Draft.count + 1
    sign_in users(:guest)
    put location_path(organization: Model.organization, legacy_table_name: Model.legacy_table_name, id: location.id), params: build_params({name: draft_name, status: "Rescued"})
    location.reload
    draft = location.drafts.last
    assert_response :redirect
    assert_equal(expected_locations, Model.count)
    assert_equal(expected_drafts, Draft.count)
    assert_equal(location_name, location.name)
    assert_equal(draft_name, draft.info['name'])
    assert_equal("Rescued", Draft.last.info["status"])
  end

  test "archives if user admin" do
    location = locations(:family_rescuees)
    expected_count = Model.count - 1
    sign_in users(:admin)
    post archive_location_path(organization: Model.organization, legacy_table_name: Model.legacy_table_name, id: location.id)
    assert_response :redirect
    assert_equal(expected_count, Model.count)
  end

  test "guests may not archive" do
    location = locations(:family_rescuees)
    expected_count = Model.count
    sign_in users(:guest)
    post archive_location_path(organization: Model.organization, legacy_table_name: Model.legacy_table_name, id: location.id)
    assert_response :redirect
    assert_equal(expected_count, Model.count)
  end

  test "loads drafts" do
    get drafts_locations_path(organization: Model.organization, legacy_table_name: Model.legacy_table_name)
    assert_response :success
  end
end

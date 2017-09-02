require 'test_helper'

class SheltersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  fixtures :all

  test "load index" do
    get shelters_path
    assert_response :success
  end

  test "load show" do
    get shelter_path(shelters(:nrg))
    assert_response :success
  end

  test "load new" do
    get new_shelter_path
    assert_response :success
  end

  test "creates new shelter if user is admin" do
    expected_count = Shelter.count + 1
    name = "Example Shelter"
    sign_in users(:admin)
    post shelters_path, params: { shelter: { shelter: name }}
    assert_response :redirect
    assert_equal(expected_count, Shelter.count)
    assert_equal(name, Shelter.last.shelter)
  end

  test "creates new draft if user is guest creating a shelter" do
    expected_shelters = Shelter.count
    expected_drafts = Draft.count + 1
    name = "Example Shelter"
    sign_in users(:guest)
    post shelters_path, params: { shelter: { shelter: name }}
    assert_response :redirect
    assert_equal(expected_shelters, Shelter.count)
    assert_equal(expected_drafts, Draft.count)
    assert_equal(name, Draft.last.info["shelter"])
  end

  test "loads edit" do
    get edit_shelter_path(shelters(:nrg))
    assert_response :success
  end

  test "updates if user admin" do
    shelter = shelters(:nrg)
    name = "Some random name you should never name a shelter"
    expected_count = Shelter.count
    sign_in users(:admin)
    put shelter_path(shelter), params: { shelter: { shelter: name }}
    shelter.reload
    assert_response :redirect
    assert_equal(expected_count, Shelter.count)
    assert_equal(name, shelter.shelter)
  end

  test "creates new draft if user is guest updating a shelter" do
    shelter = shelters(:nrg)
    shelter_name = shelter.shelter
    draft_name = "Some random name you should never name a shelter"
    expected_shelters = Shelter.count
    expected_drafts = Draft.count + 1
    sign_in users(:guest)
    put shelter_path(shelter), params: { shelter: { shelter: draft_name }}
    shelter.reload
    draft = shelter.drafts.last
    assert_response :redirect
    assert_equal(expected_shelters, Shelter.count)
    assert_equal(expected_drafts, Draft.count)
    assert_equal(shelter_name, shelter.shelter)
    assert_equal(draft_name, draft.info['shelter'])
  end

  test "loads drafts" do
    get drafts_shelters_path
    assert_response :success
  end
end

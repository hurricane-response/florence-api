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
    assert_equal expected_count, Shelter.count
    assert_equal name, Shelter.last.shelter
  end

  test "creates new draft if user is guest creating a shelter" do
    expected_shelters = Shelter.count
    expected_drafts = Draft.count + 1
    name = "Example Shelter"
    sign_in users(:guest)
    post shelters_path, params: { shelter: { shelter: name }}
    assert_response :redirect
    assert_equal expected_shelters, Shelter.count
    assert_equal expected_drafts, Draft.count
    assert_equal name, Draft.last.info["shelter"]
  end

  test "loads edit" do
    get edit_shelter_path(shelters(:nrg))
    assert_response :success
  end

  test "updates if user admin" do
    shelter = shelters(:nrg)
    name = "Some random name you should never name a shelter"
    expected_count = Shelter.count
    expected_drafts = Draft.count
    sign_in users(:admin)
    put shelter_path(shelter), params: { shelter: { shelter: name }}
    shelter.reload
    assert_response :redirect
    assert_equal expected_count, Shelter.count
    assert_equal expected_drafts, Draft.count
    assert_equal name, shelter.shelter
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
    assert_equal expected_shelters, Shelter.count
    assert_equal expected_drafts, Draft.count
    assert_equal shelter_name, shelter.shelter
    assert_equal draft_name, draft.info['shelter']
  end

  test "archives if user admin" do
    shelter = shelters(:nrg)
    expected_count = Shelter.count - 1
    sign_in users(:admin)
    post archive_shelter_path(shelter)
    assert_response :redirect
    assert_equal expected_count, Shelter.count
  end

  test "guests may not archive" do
    shelter = shelters(:nrg)
    expected_count = Shelter.count
    sign_in users(:guest)
    post archive_shelter_path(shelter)
    assert_response :redirect
    assert_equal expected_count, Shelter.count
  end

  test "reactivates if user admin" do
    shelter = shelters(:inactive)
    expected_count = Shelter.count + 1
    sign_in users(:admin)
    delete unarchive_shelter_path(shelter)
    assert_response :redirect
    assert_equal expected_count, Shelter.count
  end

  test "guests may not reactive" do
    shelter = shelters(:inactive)
    expected_count = Shelter.count
    sign_in users(:guest)
    delete unarchive_shelter_path(shelter)
    assert_response :redirect
    assert_equal expected_count, Shelter.count
  end

  test "should get archived index" do
    get archived_shelters_url
    assert_response :success
  end

  test "loads drafts" do
    get drafts_shelters_path
    assert_response :success
  end

  test "viewers cannot mark current" do
    shelter = shelters(:nrg)
    oldtimestamp = shelter.updated_at
    sleep 0.1
    post mark_current_shelter_path(shelter)
    assert_response :redirect
    assert_redirected_to root_path
    shelter.reload
    assert_equal oldtimestamp, shelter.updated_at
  end

  test "users can mark current" do
    shelter = shelters(:nrg)
    oldtimestamp = shelter.updated_at
    sleep 0.1
    sign_in users(:guest)
    post mark_current_shelter_path(shelter)
    assert_response :redirect
    assert_redirected_to outdated_shelters_path
    shelter.reload
    refute_equal oldtimestamp, shelter.updated_at
  end

  test "admins can mark current" do
    shelter = shelters(:nrg)
    oldtimestamp = shelter.updated_at
    sleep 0.1
    sign_in users(:admin)
    post mark_current_shelter_path(shelter)
    assert_response :redirect
    assert_redirected_to outdated_shelters_path
    shelter.reload
    refute_equal oldtimestamp, shelter.updated_at
  end
end

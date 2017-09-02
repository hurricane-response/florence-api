require 'test_helper'

class NeedsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  fixtures :all

  test "load index" do
    get needs_path
    assert_response :success
  end

  test "load show" do
    get need_path(needs(:katy))
    assert_response :success
  end

  test "load new" do
    get new_need_path
    assert_response :success
  end

  test "creates new need if user is admin" do
    expected_count = Need.count + 1
    name = "Example Need"
    sign_in users(:admin)
    post needs_path, params: { need: { location_name: name }}
    assert_response :redirect
    assert_equal(expected_count, Need.count)
    assert_equal(name, Need.last.location_name)
  end

  test "creates new draft if user is guest creating a need" do
    expected_needs = Need.count
    expected_drafts = Draft.count + 1
    name = "Example Need"
    sign_in users(:guest)
    post needs_path, params: { need: { location_name: name }}
    assert_response :redirect
    assert_equal(expected_needs, Need.count)
    assert_equal(expected_drafts, Draft.count)
    assert_equal(name, Draft.last.info["location_name"])
  end

  test "loads edit" do
    get edit_need_path(needs(:katy))
    assert_response :success
  end

  test "updates if user admin" do
    need = needs(:katy)
    name = "Some random name you should never name a need"
    expected_count = Need.count
    sign_in users(:admin)
    put need_path(need), params: { need: { location_name: name }}
    need.reload
    assert_response :redirect
    assert_equal(expected_count, Need.count)
    assert_equal(name, need.location_name)
  end

  test "creates new draft if user is guest updating a need" do
    need = needs(:katy)
    need_name = need.location_name
    draft_name = "Some random name you should never name a need"
    expected_needs = Need.count
    expected_drafts = Draft.count + 1
    sign_in users(:guest)
    put need_path(need), params: { need: { location_name: draft_name }}
    need.reload
    draft = need.drafts.last
    assert_response :redirect
    assert_equal(expected_needs, Need.count)
    assert_equal(expected_drafts, Draft.count)
    assert_equal(need_name, need.location_name)
    assert_equal(draft_name, draft.info['location_name'])
  end

  test "loads drafts" do
    get drafts_needs_path
    assert_response :success
  end
end

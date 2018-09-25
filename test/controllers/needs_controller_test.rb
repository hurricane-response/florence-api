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

  test "creates new and accepted draft if admin user creates a need" do
    expected_needs = Need.count + 1
    expected_drafts = Draft.count + 1
    name = 'Example Need'
    sign_in users(:admin)
    post needs_path, params: { need: { location_name: name }}
    need = Need.last
    draft = need.drafts.last
    assert_response :redirect
    assert_equal expected_needs, Need.count
    assert_equal expected_drafts, Draft.count
    assert_equal name, need.location_name
    assert_equal name, draft.info['location_name']
    assert_equal users(:admin), draft.accepted_by
    assert_nil draft.denied_by
  end

  test "creates new need if user is admin" do
    expected_count = Need.count + 1
    name = 'Example Need'
    sign_in users(:admin)
    post needs_path, params: { need: { location_name: name }}
    assert_response :redirect
    assert_equal expected_count, Need.count
    assert_equal name, Need.last.location_name
  end

  test "creates new draft if guest user creates a need" do
    expected_needs = Need.count
    expected_drafts = Draft.count + 1
    name = 'Example Need'
    sign_in users(:guest)
    post needs_path, params: { need: { location_name: name }}
    draft = Draft.last
    assert_response :redirect
    assert_equal expected_needs, Need.count
    assert_equal expected_drafts, Draft.count
    assert_equal name, draft.info['location_name']
    assert_nil draft.accepted_by
    assert_nil draft.denied_by
  end

  test "loads edit" do
    get edit_need_path(needs(:katy))
    assert_response :success
  end

  test "creates new and accepted draft if admin user updates a need" do
    need = needs(:katy)
    name = 'Some random name you should never name a need'
    expected_needs = Need.count
    expected_drafts = Draft.count + 1
    sign_in users(:admin)
    put need_path(need), params: { need: { location_name: name }}
    need.reload
    draft = need.drafts.last
    assert_response :redirect
    assert_equal expected_needs, Need.count
    assert_equal expected_drafts, Draft.count
    assert_equal name, need.location_name
    assert_equal name, draft.info['location_name']
    assert_equal users(:admin), draft.accepted_by
    assert_nil draft.denied_by
  end

  test "updates if user is admin" do
    need = needs(:katy)
    name = 'Some random name you should never name a need'
    expected_count = Need.count
    sign_in users(:admin)
    put need_path(need), params: { need: { location_name: name }}
    need.reload
    assert_response :redirect
    assert_equal expected_count, Need.count
    assert_equal name, need.location_name
  end

  test "creates new draft if guest user updates a need" do
    need = needs(:katy)
    need_name = need.location_name
    draft_name = 'Some random name you should never name a need'
    expected_needs = Need.count
    expected_drafts = Draft.count + 1
    sign_in users(:guest)
    put need_path(need), params: { need: { location_name: draft_name }}
    need.reload
    draft = need.drafts.last
    assert_response :redirect
    assert_equal expected_needs, Need.count
    assert_equal expected_drafts, Draft.count
    assert_equal need_name, need.location_name
    assert_equal draft_name, draft.info['location_name']
    assert_nil draft.accepted_by
    assert_nil draft.denied_by
  end

  test "archives if user is admin" do
    need = needs(:katy)
    expected_count = Need.count - 1
    sign_in users(:admin)
    post archive_need_path(need)
    assert_response :redirect
    assert_equal expected_count, Need.count
  end

  test "guests may not archive" do
    need = needs(:katy)
    expected_count = Need.count
    sign_in users(:guest)
    post archive_need_path(need)
    assert_response :redirect
    assert_equal expected_count, Need.count
  end

  test "loads drafts" do
    get drafts_needs_path
    assert_response :success
  end
end

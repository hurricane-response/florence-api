require 'test_helper'

class CharitableOrganizationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  fixtures :all

  test "load index" do
    get charitable_organizations_path
    assert_response :success
  end

  test "load show" do
    get charitable_organization_path(charitable_organizations(:one))
    assert_response :success
  end

  test "load new" do
    get new_charitable_organization_path
    assert_response :success
  end

  test "creates new charitable_organization if user is admin" do
    expected_count = CharitableOrganization.count + 1
    name = "Example Charitable Organization"
    sign_in users(:admin)
    post charitable_organizations_path, params: { charitable_organization: { name: name }}
    assert_response :redirect
    assert_equal(expected_count, CharitableOrganization.count)
    assert_equal(name, CharitableOrganization.last.name)
  end

  test "creates new draft if user is guest creating a charitable_organization" do
    expected_charitable_organizations = CharitableOrganization.count
    expected_drafts = Draft.count + 1
    name = "Example CharitableOrganization"
    sign_in users(:guest)
    post charitable_organizations_path, params: { charitable_organization: { name: name }}
    assert_response :redirect
    assert_equal(expected_charitable_organizations, CharitableOrganization.count)
    assert_equal(expected_drafts, Draft.count)
    assert_equal(name, Draft.last.info["name"])
  end

  test "loads edit" do
    get edit_charitable_organization_path(charitable_organizations(:one))
    assert_response :success
  end

  test "updates if user admin" do
    charitable_organization = charitable_organizations(:one)
    name = "Some random name you should never name a charitable organization"
    expected_count = CharitableOrganization.count
    sign_in users(:admin)
    put charitable_organization_path(charitable_organization), params: { charitable_organization: { name: name }}
    charitable_organization.reload
    assert_response :redirect
    assert_equal(expected_count, CharitableOrganization.count)
    assert_equal(name, charitable_organization.name)
  end

  test "creates new draft if user is guest updating a charitable_organization" do
    charitable_organization = charitable_organizations(:one)
    charitable_organization_name = charitable_organization.name
    draft_name = "Some random name you should never name a charitable_organization"
    expected_charitable_organizations = CharitableOrganization.count
    expected_drafts = Draft.count + 1
    sign_in users(:guest)
    put charitable_organization_path(charitable_organization), params: { charitable_organization: { name: draft_name }}
    charitable_organization.reload
    draft = charitable_organization.drafts.last
    assert_response :redirect
    assert_equal(expected_charitable_organizations, CharitableOrganization.count)
    assert_equal(expected_drafts, Draft.count)
    assert_equal(charitable_organization_name, charitable_organization.name)
    assert_equal(draft_name, draft.info['name'])
  end

  test "loads drafts" do
    get drafts_charitable_organizations_path
    assert_response :success
  end
end

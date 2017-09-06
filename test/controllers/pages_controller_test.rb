require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  fixtures :all

  test "should get index if user is admin" do
    sign_in users(:admin)
    get pages_path
    assert_response :success
  end

  test "should redirect if user is not admin" do
    get pages_path
    assert_response :redirect
  end

  test "should get edit if user is admin" do
    sign_in users(:admin)
    get edit_page_path(pages(:home))
    assert_response :success
  end

  test "should update if user is admin" do
    page = pages(:home)
    content = "updated page content"
    expected_count = Page.count
    sign_in users(:admin)
    put page_path(page), params: { page: { content: content }}
    page.reload
    assert_response :redirect
    assert_equal(expected_count, Page.count)
    assert_equal(content, page.content)
  end
end

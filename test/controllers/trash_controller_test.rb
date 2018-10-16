require 'test_helper'

class TrashControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    Shelter.destroy_all
    DistributionPoint.destroy_all
  end

  fixtures :all

  test "load index" do
    get trash_index_path
    assert_response :success
  end

  test "load show shelter" do
    get trash_path(trash(:trash_shelter1))
    assert_response :success
  end

  test "load show distribution point" do
    get trash_path(trash(:trash_pod1))
    assert_response :success
  end

  test "visitors cannot restore trash" do
    trashCount = Trash.count
    delete trash_path(trash(:trash_shelter1))
    assert_response :redirect
    assert_redirected_to root_path
    assert_equal 0, Shelter.count
    assert_equal trashCount, Trash.count
  end

  test "guests cannot restore trash" do
    trashCount = Trash.count
    sign_in users(:guest)
    delete trash_path(trash(:trash_shelter1))
    assert_response :redirect
    assert_redirected_to root_path
    assert_equal 0, Shelter.count
    assert_equal trashCount, Trash.count
  end

  test "admin can restore trash" do
    trashCount = Trash.count
    sign_in users(:admin)
    delete trash_path(trash(:trash_shelter1))
    assert_response :redirect
    assert_redirected_to shelter_path(1)
    assert_equal 1, Shelter.count
    assert_equal trashCount - 1, Trash.count
  end
end

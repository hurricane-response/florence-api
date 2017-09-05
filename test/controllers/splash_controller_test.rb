require 'test_helper'

class SplashControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get splash_index_url
    assert_response :success
  end

end

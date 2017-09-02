require 'test_helper'

class MuckedHomesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mucked_homes_index_url
    assert_response :success
  end

end

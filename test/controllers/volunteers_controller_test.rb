require 'test_helper'

class VolunteersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get volunteers_index_url
    assert_response :success
  end

end

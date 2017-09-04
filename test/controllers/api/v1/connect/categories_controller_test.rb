require 'test_helper'

class Api::V1::Connect::CategoriesControllerTest < ActionDispatch::IntegrationTest

  test "returns all categories" do
    get api_v1_connect_categories_path
    json = JSON.parse(response.body)
    categories = Rails.application.config_for(:connect_categories)
    assert_equal json, categories
  end
end

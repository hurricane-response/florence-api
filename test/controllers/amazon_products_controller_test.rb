require 'test_helper'

class AmazonProductsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  fixtures :all

  test "products required admin" do
    get amazon_products_path
    assert_response :redirect
    sign_in users(:admin)
    get amazon_products_path
    assert_response :success
  end

  test "load show" do
    get amazon_product_path(amazon_products(:baby_formula))
    assert_response :redirect
    sign_in users(:admin)
    get amazon_product_path(amazon_products(:baby_formula))
    assert_response :success
  end

  test "Can update" do
    sign_in users(:admin)
    patch amazon_product_path(amazon_products(:baby_formula)),
      params: { amazon_product: { asin: "NEWASIN", priority: false, disabled: true }}

    product = amazon_products(:baby_formula)
    product.reload
    assert_equal "NEWASIN", product.asin
    assert_equal false, product.priority
    assert_equal true, product.disabled
  end

end

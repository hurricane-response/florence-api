require 'test_helper'

class Api::AmazonProductsControllerTest < ActionDispatch::IntegrationTest

  test "returns all needs" do
    needs = Need.all.map(&:clean_needs).flatten.uniq
    count = AmazonProduct.active.where(need: needs).count
    get "/api/v1/products"
    json = JSON.parse(response.body)
    assert_equal count, json["products"].length
    assert_equal count, json["meta"]["result_count"]
  end

  test "filters are returned" do
    needs = Need.all.map(&:clean_needs).flatten.uniq.select{|n| n.include? 'baby'}
    count = AmazonProduct.active.where(need: needs).count
    get "/api/v1/products?need=baby"
    json = JSON.parse(response.body)

    assert_equal count, json["products"].length
    assert_equal count, json["meta"]["result_count"]
    assert_equal "baby", json["meta"]["filters"]["need"]
  end
end

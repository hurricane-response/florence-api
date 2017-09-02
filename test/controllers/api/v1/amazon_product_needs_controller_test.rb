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

  test "filters are returned for need" do
    needs = Need.all.map(&:clean_needs).flatten.uniq.select{|n| n.include? 'baby'}
    count = AmazonProduct.active.where(need: needs).count
    get "/api/v1/products?need=baby"
    json = JSON.parse(response.body)

    assert_equal count, json["products"].length
    assert_equal count, json["meta"]["result_count"]
    assert_equal "baby", json["meta"]["filters"]["need"]
  end

  test "filters are returned for priority" do
    get "/api/v1/products?priority=true"
    json = JSON.parse(response.body)
    assert_equal "true", json["meta"]["filters"]["priority"]
  end

  test "filters are returned for limit" do
    get "/api/v1/products?limit=1"
    json = JSON.parse(response.body)
    assert_equal 1, json["products"].length
    assert_equal 1, json["meta"]["filters"]["limit"]
  end
end

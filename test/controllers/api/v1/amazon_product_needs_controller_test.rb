require 'test_helper'

class Api::AmazonProductsControllerTest < ActionDispatch::IntegrationTest
  test 'returns all needs' do
    needs = Need.all.map(&:clean_needs).flatten.uniq
    count = AmazonProduct.active.where(need: needs).count
    get '/api/v1/products'
    json = JSON.parse(response.body)
    assert_equal count, json['products'].length
    assert_equal count, json['meta']['result_count']
  end

  test 'filters are returned for need' do
    needs = Need.all.map(&:clean_needs).flatten.uniq.select { |n| n.include? 'baby' }
    count = AmazonProduct.active.where(need: needs).count
    get '/api/v1/products?need=baby'
    json = JSON.parse(response.body)

    assert_equal count, json['products'].length
    assert_equal count, json['meta']['result_count']
    assert_equal 'baby', json['meta']['filters']['need']
  end

  test 'filters are returned for priority' do
    get '/api/v1/products?priority=true'
    json = JSON.parse(response.body)
    assert_equal 'true', json['meta']['filters']['priority']
  end

  test 'filters are returned for limit' do
    get '/api/v1/products?limit=1'
    json = JSON.parse(response.body)
    assert_equal 1, json['products'].length
    assert_equal 1, json['meta']['filters']['limit']
  end

  test 'categories are returned' do
    needs(:katy).update(tell_us_about_the_supply_needs: 'garbage bags')
    get '/api/v1/products?limit=1'
    json = JSON.parse(response.body)
    product = json['products'].first
    assert product['category_specific'].present?
    assert product['category_general'].present?
  end

  test 'categories can be filtered (specific)' do
    needs(:katy).update(tell_us_about_the_supply_needs: 'garbage bags')
    get '/api/v1/products?category=cleanup'
    json = JSON.parse(response.body)
    products = json['products']
    assert products.map { |p| p['asin'] }.include? amazon_products(:garbage_bags).asin
  end

  test 'categories can be filtered (general)' do
    needs(:katy).update(tell_us_about_the_supply_needs: 'garbage bags')
    get '/api/v1/products?category=household'
    json = JSON.parse(response.body)
    products = json['products']
    assert products.map { |p| p['asin'] }.include? amazon_products(:garbage_bags).asin
  end

  test 'Does not return products without a category' do
    amazon_products(:baby_formula).update(
      category_specific: '',
      category_general: ''
    )
    get '/api/v1/products'
    json = JSON.parse(response.body)
    products = json['products']
    refute products.map { |p| p['asin'] }.include? amazon_products(:baby_formula).asin
  end

  test 'Does not return products without a price' do
    amazon_products(:baby_formula).update(price_in_cents: 0)
    get '/api/v1/products'
    json = JSON.parse(response.body)
    products = json['products']
    refute products.map { |p| p['asin'] }.include? amazon_products(:baby_formula).asin
  end
end

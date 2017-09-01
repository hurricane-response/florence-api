require 'test_helper'

class AmazonProductTest < ActiveSupport::TestCase

  test ":active does not include disabled" do
    AmazonProduct.destroy_all
    formula = AmazonProduct.create! need: "baby formula", asin: "XXXXXX", detail_url: "http"
    AmazonProduct.create! disabled: true, need: "opens at 6", asin: "XXXXXX", detail_url: "http"

    assert_equal [formula], AmazonProduct.active
  end
end

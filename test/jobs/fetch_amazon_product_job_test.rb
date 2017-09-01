require 'test_helper'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "test/vcr_cassettes"
  config.hook_into :excon
end

def sanitize_qs query_string
  hash = CGI::parse query_string
  hash.delete "Signature"
  hash.delete "Timestamp"
  hash
end

class FetchAmazonProductJobTest < ActiveJob::TestCase

  # What are we doing here? The Amazon URLS have a timestamp and signature
  #   and they change constantly. So let's compare bsed on without those
  #   sorry for this, but don't want to have it reach out to amazon on every
  #   test run
  amazon_url_matcher = lambda do |request_1, request_2|
    url_1 = URI(request_1.uri)
    url_2 = URI(request_2.uri)
    (url_1.path == url_2.path ) &&
        (url_1.host == url_2.host ) &&
        (sanitize_qs(url_1.query) == sanitize_qs(url_2.query))
  end


  test "Creates correct amazon product" do

    VCR.use_cassette("amazon", :match_requests_on => [:method, amazon_url_matcher])  do

      FetchAmazonProductJob.perform_now "trash bags (kitchen and contractor size)"
      AmazonProduct.pluck(:need).include? "trash bags (kitchen and contractor size)"
      FetchAmazonProductJob.perform_now "baby formula"
      AmazonProduct.pluck(:need).include? "baby formula"
    end
  end

  test "updates if already exists" do

    VCR.use_cassette("amazon", :allow_playback_repeats => true, :match_requests_on => [:method, amazon_url_matcher])  do
      AmazonProduct.destroy_all
      FetchAmazonProductJob.perform_now "trash bags (kitchen and contractor size)"
      FetchAmazonProductJob.perform_now "trash bags (kitchen and contractor size)"
      assert_equal 1, AmazonProduct.count
    end
  end

  test "If no result found, create ignored request" do

    VCR.use_cassette("amazon-missing", :allow_playback_repeats => true, :match_requests_on => [:method, amazon_url_matcher])  do
      AmazonProduct.destroy_all
      IgnoredAmazonProductNeed.destroy_all
      FetchAmazonProductJob.perform_now "987345jh4nksad.hy98asd67fsjsd"
      assert_equal 0, AmazonProduct.count
      assert_equal 1, IgnoredAmazonProductNeed.count
    end
  end

end

require 'vacuum'

class FetchAmazonProductJob < ApplicationJob
  queue_as :default

  # The amazon product advertising API rate limits us pretty hard
  # So we need the connection_pool and redis to count our req/s
  # And the trafic control will re-schedule jobs
  throttle threshold: 10, period: 20.seconds unless Rails.env.test?

  def perform need

    request = Vacuum.new
    request.configure(
      aws_access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID", "AKIAJ5PESCDQX7KIMQ5Q"),
      aws_secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY", ""),
      associate_tag: ENV.fetch("AWS_ASSOCIATE_TAG", "oneclickrelie-20")
    )

    Rails.logger.debug "Finding for #{need}"

    response = request.item_search(
      query: {
        'Keywords' => need,
        'Availability' => 'Available',
        'MerchantId' => 'Amazon',
        'SearchIndex' => 'All'
      }
    )

    error_code = response.dig("ItemSearchResponse",
                              "Items",
                              "Request",
                              "Errors",
                              "Error",
                              "Code")

    if error_code == "AWS.ECommerceService.NoExactMatches"
      IgnoredAmazonProductNeed.create need: need
      return
    end

    item = response.dig('ItemSearchResponse', 'Items', 'Item').first

    amazon_product = AmazonProduct
          .where("need ILIKE ?", "%#{need}%")
          .first_or_initialize
    amazon_product.need = need
    amazon_product.amazon_title = item["ItemAttributes"]["Title"]
    amazon_product.asin = item["ASIN"]
    amazon_product.detail_url = item["DetailPageURL"]

    amazon_product.save!
  end

end

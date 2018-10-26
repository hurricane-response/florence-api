namespace :amazon do
  desc 'Delete expensive products'
  task pricing: :environment do
    Rails.logger.info 'Amazon::Pricing'

    ## Find products; delete over $30
    ## Schedule to re-find products

    def response_for_product(products)
      products = Array(products)

      request = Vacuum.new
      request.configure(
        aws_access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID', 'AKIAJ5PESCDQX7KIMQ5Q'),
        aws_secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY', ''),
        associate_tag: ENV.fetch('AWS_ASSOCIATE_TAG', 'oneclickrelie-20')
      )

      response = request.item_lookup(
        query: {
          'ItemId' => products.map(&:asin).join(','),
          'ResponseGroup' => 'ItemAttributes, BrowseNodes,Offers'
        }
      )
      item = response.dig 'ItemLookupResponse', 'Items', 'Item'
      if item.is_a? Array
        item
      else
        [item]
      end
    end

    all_products = AmazonProduct.all
    Rails.logger.debug("Amazon::Pricing -> Finding for #{all_products.count} products")
    all_products.in_groups_of(10, false) do |products|
      items = response_for_product products
      items.each do |item|
        next unless item.present?

        asin = item['ASIN']
        product = AmazonProduct.find_by(asin: asin)
        next unless product.present?

        price = item.dig('Offers', 'Offer', 'OfferListing', 'Price', 'Amount')
        if price.to_i > 3000
          puts "Deleting #{product.amazon_title} with a price of #{price}"
          FetchAmazonProductJob.perform_later product.need
          product.destroy
        else
          product.update price_in_cents: price.to_i
        end
      end

      sleep 3
    end
  end

  desc 'Find asin categories for products without categories'
  task category: :environment do
    Rails.logger.info 'Amazon::Category'

    ## Find product categories en mass
    ## Run this on production every hour or so

    def response_for_product(products)
      products = Array(products)

      request = Vacuum.new
      request.configure(
        aws_access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID', 'AKIAJ5PESCDQX7KIMQ5Q'),
        aws_secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY', ''),
        associate_tag: ENV.fetch('AWS_ASSOCIATE_TAG', 'oneclickrelie-20')
      )

      response = request.item_lookup(
        query: {
          'ItemId' => products.map(&:asin).join(','),
          'ResponseGroup' => 'ItemAttributes, BrowseNodes'
        }
      )
      item = response.dig 'ItemLookupResponse', 'Items', 'Item'
      if item.is_a? Array
        item
      else
        [item]
      end
    end

    def top_ancestor(node)
      if node['Ancestors']
        top_ancestor(node['Ancestors']['BrowseNode'])
      else
        node['Name']
      end
    end

    no_category_products = AmazonProduct.where(category_specific: '')
    Rails.logger.debug("Amazon::Category -> Finding for #{no_category_products.count} products")
    no_category_products.in_groups_of(10, false) do |products|
      items = response_for_product products
      items.each do |item|
        next unless item.present?

        asin = item['ASIN']
        product = AmazonProduct.find_by(asin: asin)
        next unless product.present?

        name = product.amazon_title

        if item['BrowseNodes'].blank?
          first = item['ProductGroup']
          last = item['ProductGroup']
        elsif item['BrowseNodes']['BrowseNode'].is_a? Array
          first = item['BrowseNodes']['BrowseNode'].first['Name']
          last = top_ancestor item['BrowseNodes']['BrowseNode'].first
        else
          first = item['BrowseNodes']['BrowseNode']['Name']
          last = top_ancestor item['BrowseNodes']['BrowseNode']
        end
        product.category_general = last
        product.category_specific = first
        product.save
      end

      sleep 3
    end
  end
end

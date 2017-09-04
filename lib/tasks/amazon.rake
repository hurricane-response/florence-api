namespace :amazon do
  desc "Find asin categories for products without categories"
  task :category => :environment do

    Rails.logger.info "Amazon::Category"

    ## Find product categories en mass
    ## Run this on production every hour or so

    def response_for_product(products)
      products = Array(products)

      request = Vacuum.new
      request.configure(
        aws_access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID", "AKIAJ5PESCDQX7KIMQ5Q"),
        aws_secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY", ""),
        associate_tag: ENV.fetch("AWS_ASSOCIATE_TAG", "oneclickrelie-20")
      )

      response = request.item_lookup(
        query: {
          'ItemId' => products.map(&:asin).join(","),
          "ResponseGroup" => "ItemAttributes, BrowseNodes"
        }
      )
      item = response.dig "ItemLookupResponse", "Items", "Item"
      if item.is_a? Array
        item
      else
        [item]
      end
    end

    def top_ancestor(node)
      if node["Ancestors"]
        return top_ancestor(node["Ancestors"]["BrowseNode"])
      else
        return node["Name"]
      end
    end

    products = AmazonProduct.where(category_specific: "")
    Rails.logger.debug("Amazon::Category -> Finding for #{products.count} products")
    products.in_groups_of(10, false) do |products|
      items = response_for_product products
      items.each do |item|
        next unless item.present?
        asin = item["ASIN"]
        product = AmazonProduct.find_by(asin: asin)
        next unless product.present?

        name = product.amazon_title

        if item["BrowseNodes"].blank?
          first = item["ProductGroup"]
          last = item["ProductGroup"]
        elsif item["BrowseNodes"]["BrowseNode"].is_a? Array
          first = item["BrowseNodes"]["BrowseNode"].first["Name"]
          last = top_ancestor item["BrowseNodes"]["BrowseNode"].first
        else
          first = item["BrowseNodes"]["BrowseNode"]["Name"]
          last = top_ancestor item["BrowseNodes"]["BrowseNode"]
        end
        hash = {asin: asin, name: name, first: first, last: last}
        product.category_general = last
        product.category_specific = first
        product.save

      end

      sleep 3

    end
  end

end

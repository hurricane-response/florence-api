amazon_json = JSON.parse File.read("#{Rails.root}/db/seeds/amazon_products.json")
amazon_json.each do |json|
  ap = AmazonProduct.where(need: json["need"]).first_or_initialize
  ap.attributes = json
  ap.save
end

ignored_json = JSON.parse File.read("#{Rails.root}/db/seeds/ignored_amazon_product_needs.json")
ignored_json.each do |json|
  iapn= IgnoredAmazonProductNeed.where(need: json["need"]).first_or_initialize
  iapn.attributes = json
  iapn.save
end

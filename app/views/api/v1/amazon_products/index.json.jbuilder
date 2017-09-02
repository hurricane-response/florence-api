json.products @products do |product|
  json.extract! product, :need, :asin, :amazon_title, :detail_url, :priority
end

json.meta do
  json.filters @filters
  json.result_count @products.count
end

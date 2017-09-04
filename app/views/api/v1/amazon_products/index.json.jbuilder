json.products @products do |product|
  json.extract! product, :need, :asin, :amazon_title, :detail_url,
                         :priority, :category_specific, :category_general
end

json.meta do
  json.filters @filters
  json.result_count @products.count
end

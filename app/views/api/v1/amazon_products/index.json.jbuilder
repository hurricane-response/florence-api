json.cache! @shelters do
  json.products @products do |product|
    json.cache! product do
      json.partial! product
    end
  end
end

json.meta do
  json.filters @filters
  json.result_count @products.count
end

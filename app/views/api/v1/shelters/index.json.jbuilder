json.cache! @shelters do
  json.shelters @shelters do |shelter|
    json.cache! shelter do
      json.partial! shelter
    end
  end
end

json.meta do
  json.result_count @shelters.length
  json.filters @filters
end

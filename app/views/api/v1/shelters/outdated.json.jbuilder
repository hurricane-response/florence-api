json.cache! @outdated do
  json.shelters @outdated do |shelter|
    json.cache! shelter do
      json.partial! shelter
    end
  end
end

json.meta do
  json.result_count @outdated.length
  json.filters @filters
end

json.cache! @locations do
  json.locations @locations do |location|
    json.cache! location do
      json.partial! "location", location: location
    end
  end
end

json.meta do
  json.result_count @locations.length
  json.filters @filters
end

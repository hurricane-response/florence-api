json.shelters @shelters do |shelter|
  json.partial! shelter
end

json.meta do
  json.result_count @shelters.length
  json.filters @filters
end

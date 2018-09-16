json.cache! @outdated do
  json.shelters @outdated do |shelter|
    print shelter ? "#{shelter.id} " : '?'
    json.cache! shelter do
      json.partial! shelter
    end
  end
end

json.meta do
  json.result_count @outdated.length
  json.filters @filters
end

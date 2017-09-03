json.cache! @needs do
  json.needs @needs do |need|
    json.cache! need do
      json.partial! need
    end
  end
end

json.meta do
  json.result_count @needs.length
  json.filters @filters
end

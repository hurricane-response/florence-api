json.needs @needs do |need|
  json.partial! need
end

json.meta do
  json.result_count @needs.length
  json.filters @filters
end

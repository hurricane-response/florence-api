json.filters @location_class.filters.values do |filter|
  json.name filter.name
  json.type filter.type
  json.description filter.description
end

json.fields @location_class.api_help do |field|
  json.name field.name
  json.type field.type
  json.required field.required
  json.options field.options do |option|
    json.option option
  end
  json.description field.description
end

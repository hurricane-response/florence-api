json.distribution_points @distribution_points do |distribution_point|
  json.partial! distribution_point
end

json.meta do
  json.result_count @distribution_points.length
  json.filters @filters
end

json.type 'FeatureCollection'
json.features @distribution_points do |distribution_point|
  json.type 'Feature'
  json.geometry do
    json.type 'Point'
    json.coordinates [distribution_point.longitude, distribution_point.latitude]
  end
  json.properties do
    json.partial! distribution_point
  end
end

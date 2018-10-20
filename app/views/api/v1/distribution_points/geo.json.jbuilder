json.type "FeatureCollection"
json.features @distribution_points do |distribution_point|
  json.type "Feature"
  json.geometry do
    json.type "Point"
    json.coordinates [distribution_point.longitude, distribution_point.latitude]
  end
  json.properties do
    json.extract! distribution_point, :active, :facility_name,
      :address, :city, :county, :state, :zip,
      :created_at, :updated_at, :updated_by,
      :source, :notes, :google_place_id, :id
    json.updated_at distribution_point.updated_at.in_time_zone("Central Time (US & Canada)").rfc3339
    json.updatedAt distribution_point.updated_at.in_time_zone("Central Time (US & Canada)").rfc3339
    json.last_updated distribution_point.updated_at.in_time_zone("Central Time (US & Canada)").rfc3339
  end
end

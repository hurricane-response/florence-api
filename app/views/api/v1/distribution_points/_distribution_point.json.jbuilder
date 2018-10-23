json.extract! distribution_point, :active, :facility_name,
                                  :address, :city, :county, :state, :zip,
                                  :created_at, :updated_at, :updated_by,
                                  :source, :notes, :longitude, :latitude,
                                  :google_place_id, :id, :archived

json.updated_at distribution_point.updated_at.in_time_zone('Central Time (US & Canada)').rfc3339
json.updatedAt distribution_point.updated_at.in_time_zone('Central Time (US & Canada)').rfc3339
json.last_updated distribution_point.updated_at.in_time_zone('Central Time (US & Canada)').rfc3339

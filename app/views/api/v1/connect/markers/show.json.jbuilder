json.extract! @marker, :id, :marker_type, :name, :description, :phone, :categories,
                       :resolved, :latitude, :longitude, :address, :email, :data

json.updated_at @marker.updated_at.in_time_zone("Central Time (US & Canada)").rfc3339

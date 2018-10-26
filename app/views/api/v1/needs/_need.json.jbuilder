json.extract! need, :updated_by, :location_name,
              :location_address, :longitude, :latitude, :contact_for_this_location_name,
              :contact_for_this_location_phone_number, :are_volunteers_needed,
              :tell_us_about_the_volunteer_needs, :are_supplies_needed,
              :tell_us_about_the_supply_needs, :anything_else_you_would_like_to_tell_us,
              :source, :archived

json.needs((need.tell_us_about_the_volunteer_needs || '').split(',') + (need.tell_us_about_the_supply_needs || '').split(','))

json.updated_at need.updated_at.in_time_zone('Central Time (US & Canada)').rfc3339
json.updatedAt need.updated_at.in_time_zone('Central Time (US & Canada)').rfc3339
json.timestamp need.updated_at.in_time_zone('Central Time (US & Canada)').rfc3339

stripped_phone = (need.contact_for_this_location_phone_number || '').gsub(/\D/, '')
json.cleanPhone stripped_phone.match?(/^\d{10}$/) ? stripped_phone : 'badphone'

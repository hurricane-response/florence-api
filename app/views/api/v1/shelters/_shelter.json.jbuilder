json.extract! shelter, :accepting, :shelter,
              :address, :city, :state, :county, :zip,
              :phone, :updated_by, :notes, :volunteer_needs,
              :longitude, :latitude, :supply_needs, :source,
              :google_place_id, :special_needs, :id, :archived

json.pets shelter.allow_pets.nil? ? 'Unknown' : (shelter.allow_pets ? 'Yes' : 'No')
json.pets_notes shelter.pets
json.needs((shelter.volunteer_needs || '').split(',') + (shelter.supply_needs || '').split(','))

json.updated_at shelter.updated_at.in_time_zone('Central Time (US & Canada)').rfc3339
json.updatedAt shelter.updated_at.in_time_zone('Central Time (US & Canada)').rfc3339
json.last_updated shelter.updated_at.in_time_zone('Central Time (US & Canada)').rfc3339

stripped_phone = (shelter.phone || '').gsub(/\D/, '')
json.cleanPhone stripped_phone.match?(/^\d{10}$/) ? stripped_phone : 'badphone'

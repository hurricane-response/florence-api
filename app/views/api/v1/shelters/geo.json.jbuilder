json.type "FeatureCollection"
json.features @shelters do |shelter|
  json.type "Feature"
  json.geometry do
    json.type "Point"
    json.coordinates [shelter.longitude, shelter.latitude]
  end
  json.properties do
    json.extract! shelter, *%i[
      county shelter address city state county zip phone accepting updated_by
      notes volunteer_needs supply_needs source google_place_id
      special_needs id
    ]
    json.pets shelter.allow_pets ? 'Yes' : 'No'
    json.pets_notes shelter.pets
    json.needs (shelter.volunteer_needs ||"").split(",") + (shelter.supply_needs || "").split(",")
    json.updated_at shelter.updated_at.in_time_zone("Central Time (US & Canada)").rfc3339
    json.updatedAt shelter.updated_at.in_time_zone("Central Time (US & Canada)").rfc3339
    json.last_updated shelter.updated_at.in_time_zone("Central Time (US & Canada)").rfc3339
    stripped_phone = (shelter.phone||"").gsub(/\D/,"")
    json.cleanPhone stripped_phone.match?(/^\d{10}$/)? stripped_phone : "badphone"
  end
end

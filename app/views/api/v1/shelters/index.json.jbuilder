json.shelters @shelters do |shelter|

  json.extract! shelter, :county, :shelter, :address, :city, :pets,
    :phone, :accepting, :last_updated, :updated_by, :notes,
    :volunteer_needs, :longitude, :latitude, :supply_needs, :source

  json.needs (shelter.volunteer_needs ||"").split(",") + (shelter.supply_needs || "").split(",")

  json.updatedAt do end
end

json.meta do
  json.result_count @shelters.length
  json.filters @filters
end

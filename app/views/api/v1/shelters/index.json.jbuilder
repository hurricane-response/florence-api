json.shelters @shelters do |shelter|

  json.extract! shelter, :county, :shelter, :address, :city, :pets,
    :phone, :accepting, :last_updated, :updated_by, :notes,
    :volunteer_needs, :longitude, :latitude, :supply_needs, :source

  json.needs (shelter.volunteer_needs ||"").split(",") + (shelter.supply_needs || "").split(",")

  begin
  	json.updatedAt ActiveSupport::TimeZone["Central Time (US & Canada)"].parse(shelter.last_updated).to_datetime.rfc3339
  rescue
  	json.updatedAt "baddate"
  end
end

json.meta do
  json.result_count @shelters.length
  json.filters @filters
end

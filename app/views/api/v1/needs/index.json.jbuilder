json.needs @needs do |need|

  json.extract! need, :updated_by , :timestamp , :location_name,
    :location_address , :longitude , :latitude , :contact_for_this_location_name,
    :contact_for_this_location_phone_number , :are_volunteers_needed,
    :tell_us_about_the_volunteer_needs , :are_supplies_needed,
    :tell_us_about_the_supply_needs , :anything_else_you_would_like_to_tell_us
    :source

  json.needs (need.tell_us_about_the_volunteer_needs ||"").split(",") + (need.tell_us_about_the_supply_needs || "").split(",")

  begin
  	json.updatedAt ActiveSupport::TimeZone["Central Time (US & Canada)"].parse(need.timestamp).to_datetime.rfc3339
  rescue
  	json.updatedAt "baddate"
  end

  stripped_phone = (need.contact_for_this_location_phone_number||"").gsub(/\D/,"")
  json.cleanPhone stripped_phone.match?(/^\d{10}$/)? stripped_phone : "badphone"

end

json.meta do
  json.result_count @needs.length
  json.filters @filters
end

json.needs @needs do |need|

  json.extract! need, :updated_by , :timestamp , :location_name,
    :location_address , :longitude , :latitude , :contact_for_this_location_name,
    :contact_for_this_location_phone_number , :are_volunteers_needed,
    :tell_us_about_the_volunteer_needs , :are_supplies_needed,
    :tell_us_about_the_supply_needs , :anything_else_you_would_like_to_tell_us
    :source

end

json.meta do
  json.result_count @needs.count
  json.filters @filters
end

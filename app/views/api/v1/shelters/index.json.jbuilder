json.shelters @shelters do |shelter|

  json.extract! shelter, :county, :shelter, :address, :city, :pets,
    :phone, :accepting, :last_updated, :updated_by, :notes,
    :volunteer_needs, :longitude, :latitude, :supply_needs,
    :source

end

json.meta do
  json.result_count @shelters.count
  json.filters @filters
end

class Location
  module Whitelist
    Locations = [HurricaneHarveyRescueDispatchers]

    LocationsMap = Locations.each_with_object({}.with_indifferent_access) do |location, obj|
      organization = location.organization
      legacy_table_name = location.legacy_table_name
      obj[organization] ||= {}.with_indifferent_access
      obj[organization][legacy_table_name] ||= location
    end

    def self.find(organization, legacy_table_name)
      LocationsMap[organization] && LocationsMap[organization][legacy_table_name]
    end

    def self.organization_tables(organization)
      keys = LocationsMap[organization].keys.sort
      keys.map { |key| LocationsMap[organization][key] }
    end
  end
end

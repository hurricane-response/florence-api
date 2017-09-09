class Location
  module HHRD
    class Rescuees < Location

      # Import, Models, HTML Controller, API Controller
      config(
        legacy_table_name: "rescues",
        organization: "hurricane-harvey-rescue-dispatchers"
      )

      filter(:status)
      filter(:tier)
      filter(:high_water_vehicle_accessable, type: :truthy)
      filter(:number_of_people)
      filter(:notes)

      legacy_field(:apartment_number)
      legacy_field(:status, type: :enum, options: ["Awaiting Rescue", "Boat in Route", "Rescued"])
      legacy_field(:tier, type: :enum, options: ["Tier 1", "Tier 2", "None"])
      legacy_field(:high_water_vehicle_accessible, type: :boolean)
      legacy_field(:number_of_adults)
      legacy_field(:number_of_elderly)
      legacy_field(:number_of_children)
      legacy_field(:number_of_pets)
      legacy_field(:notes)
    end
  end
end

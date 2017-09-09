class Location
  module HHRD
    class Pois < Location

      # Import, Models, HTML Controller, API Controller
      config(
        legacy_table_name: "point-of-interest",
        organization: "hurricane-harvey-rescue-dispatchers"
      )

      filter(:rally_point, type: :truthy)
      filter(:launch_point, type: :truthy)
      filter(:diesel_fuel, type: :truthy)
      filter(:unleadded_fuel, type: :truthy)
      filter(:food, type: :truthy)
      filter(:hours)
      filter(:notes)

      legacy_field(:rally_point, type: :boolean)
      legacy_field(:launch_point, type: :boolean)
      legacy_field(:diesel_fuel, type: :boolean)
      legacy_field(:unleaded_fuel, type: :boolean)
      legacy_field(:food, type: :boolean)
      legacy_field(:hours)
      legacy_field(:notes)
    end
  end
end

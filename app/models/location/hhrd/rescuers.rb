class Location
  module HHRD
    class Rescuers < Location
      # Import, Models, HTML Controller, API Controller
      config(
        legacy_table_name: 'rescuers',
        organization: 'hurricane-harvey-rescue-dispatchers'
      )

      filter(:status)
      filter(:background_check, type: :truthy)
      filter(:medic, type: :truthy)
      filter(:mechanic, type: :truthy)
      filter(:mechanic, type: :truthy)
      filter(:has_parts, type: :truthy)
      filter(:high_water_vehicle, type: :truthy)

      legacy_field(:status, type: :enum, options: ['in route', 'returning', 'available', 'partially occupied'])
      legacy_field(:vehicle_type, type: :enum, options: ['high water vehicle', 'boat'])
      legacy_field(:capacity)
      legacy_field(:background_check, type: :boolean)
      legacy_field(:medic, type: :boolean)
      legacy_field(:mechanic, type: :boolean)
      legacy_field(:has_parts, type: :boolean)
    end
  end
end

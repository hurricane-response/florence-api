class Location
  class HurricaneHarveyRescueDispatchers < Location

    # Import, Models, HTML Controller, API Controller
    config(
      legacy_table_name: "shelters",
      organization: "hurricane-harvey-rescue-dispatchers"
    )

    filter(:coordinates)
    filter(:dynamically)
    filter(:booleans, type: :truthy)

    legacy_field(:dynamically)
    legacy_field(:defined)
    legacy_field(:fields)
    legacy_field(:booleans, type: :boolean)
  end
end

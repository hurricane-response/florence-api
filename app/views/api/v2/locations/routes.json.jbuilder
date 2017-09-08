json.routes Location::Whitelist::Locations do |location|
  json.extract! location, :organization, :legacy_table_name
  json.api_url api_v2_api_locations_url(organization: location.organization, legacy_table_name: location.legacy_table_name)
  json.api_help_url api_v2_api_locations_help_url(organization: location.organization, legacy_table_name: location.legacy_table_name)
end

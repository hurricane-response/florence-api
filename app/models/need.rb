class Need < ApplicationRecord
  ColumnNames = ["anything_else_you_would_like_to_tell_us", "are_supplies_needed", "are_volunteers_needed", "contact_for_this_location_name", "contact_for_this_location_phone_number", "created_at", "id", "latitude", "location_address", "location_name", "longitude", "source", "tell_us_about_the_supply_needs", "tell_us_about_the_volunteer_needs", "timestamp", "updated_at", "updated_by"]

  HeaderNames = ColumnNames.map(&:titleize)

  UpdateFields = ["anything_else_you_would_like_to_tell_us", "are_supplies_needed", "are_volunteers_needed", "contact_for_this_location_name", "contact_for_this_location_phone_number", "created_at", "location_address", "location_name", "source", "tell_us_about_the_supply_needs", "tell_us_about_the_volunteer_needs", "timestamp", "updated_at", "updated_by"]

  has_many :drafts, as: :record

  geocoded_by :location_address
  after_validation :geocode, if: ->(obj){ obj.location_address.present? && obj.location_address_changed? }

  def clean_needs
    return [] if tell_us_about_the_supply_needs.blank?
    tell_us_about_the_supply_needs
      .gsub("\n","")
      .gsub("*", ",")
      .split(",")
      .reject{|n| n =~ /^open/i }
      .map(&:strip)
      .select(&:present?)
  end
end

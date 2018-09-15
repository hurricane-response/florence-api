class Need < ApplicationRecord
  ColumnNames = %w[
    id location_name location_address
    contact_for_this_location_name contact_for_this_location_phone_number
    are_supplies_needed tell_us_about_the_supply_needs
    are_volunteers_needed tell_us_about_the_volunteer_needs
    anything_else_you_would_like_to_tell_us
    source created_at updated_at updated_by latitude longitude
  ].freeze

  UpdateFields = %w[
    anything_else_you_would_like_to_tell_us are_supplies_needed are_volunteers_needed
    contact_for_this_location_name contact_for_this_location_phone_number
    created_at location_address location_name source
    tell_us_about_the_supply_needs tell_us_about_the_volunteer_needs updated_at updated_by
  ]

  HeaderNames = ColumnNames.map(&:titleize)

  has_many :drafts, as: :record

  geocoded_by :location_address
  default_scope { where(active: !false) }

  def clean_needs
    return [] if tell_us_about_the_supply_needs.blank?
    tell_us_about_the_supply_needs
      .gsub("\n","")
      .gsub('*', ',')
      .split(',')
      .reject{|n| n =~ /^open/i }
      .map(&:strip)
      .select(&:present?)
  end

  after_commit do
    NeedUpdateNotifierJob.perform_later self
  end
end

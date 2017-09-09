class Shelter < ApplicationRecord
  ColumnNames = %w[
    id accepting address address_name city state county zip
    google_place_id notes pets phone shelter source supply_needs updated_by
    volunteer_needs distribution_center food_pantry updated_at latitude
    longitude
  ]

  HeaderNames = ColumnNames.map(&:titleize)

  UpdateFields = %w[
    accepting address address_name city state county zip notes pets phone
    shelter source supply_needs updated_by volunteer_needs distribution_center
    food_pantry latitude longitude google_place_id
  ]

  PrivateFields = ["private_notes"]

  has_many :drafts, as: :record
  default_scope { where(active: !false) }

  geocoded_by :address

  after_commit do
    ShelterUpdateNotifierJob.perform_later self
  end
end

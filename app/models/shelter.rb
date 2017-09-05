class Shelter < ApplicationRecord
  ColumnNames = ["id", "shelter", "address", "address_name", "city", "county", "phone", "accepting", "pets", "volunteer_needs", "supply_needs", "notes", "source", "updated_by", "updated_at", "latitude", "longitude"]

  HeaderNames = ColumnNames.map(&:titleize)

  UpdateFields = ["accepting", "address", "address_name", "city", "county", "notes", "pets", "phone", "shelter", "source", "supply_needs", "updated_by", "volunteer_needs", "latitude", "longitude"]

  has_many :drafts, as: :record
  default_scope { where(active: !false) }

  geocoded_by :address

  after_commit do
    ShelterUpdateNotifierJob.perform_later self
  end
end

class Shelter < ApplicationRecord
  ColumnNames = ["accepting", "address", "address_name", "city", "county", "id", "latitude", "longitude", "notes", "pets", "phone", "shelter", "source", "supply_needs", "updated_at", "updated_by", "volunteer_needs"]

  HeaderNames = ColumnNames.map(&:titleize)

  UpdateFields = ["accepting", "address", "address_name", "city", "county", "notes", "pets", "phone", "shelter", "source", "supply_needs", "updated_by", "volunteer_needs"]

  has_many :drafts, as: :record

  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? && obj.address_changed? }
end

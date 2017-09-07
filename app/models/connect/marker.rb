class Connect::Marker < ApplicationRecord
  MARKER_TYPES = %w(have need)

  validates :category, :device_uuid, :name, :phone, presence: true
  validates :marker_type, inclusion: { in: MARKER_TYPES, allow_blank: false }
  validates :latitude, :longitude, numericality: { other_than: 0 }
  validates :email, format: { with: /@/, allow_nil: true }

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode, if: :coordinates_changed?

  scope :unresolved, -> { where(resolved: false) }

  def coordinates_changed?
    return false if self.latitude.zero? || self.longitude.zero?
    self.latitude_changed? || self.longitude_changed?
  end
end

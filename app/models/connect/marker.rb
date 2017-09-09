# frozen_string_literal: true

module Connect
  class Marker < ApplicationRecord
    MARKER_TYPES = %w[have need].freeze

    validates :categories, :device_uuid, :name, :phone, presence: true
    validates :marker_type, inclusion: { in: MARKER_TYPES, allow_blank: false }
    validates :latitude, :longitude, numericality: { other_than: 0 }
    validates :email, format: { with: /@/, allow_nil: true }

    reverse_geocoded_by :latitude, :longitude
    after_validation :reverse_geocode, if: :coordinates_changed?

    scope :by_category, ->(category) { where('categories ? :category', category: category) }
    scope :by_device_uuid, ->(device_uuid) { where(device_uuid: device_uuid) }
    scope :by_type, ->(type) { where(marker_type: type) }
    scope :resolved, -> { where(resolved: true) }
    scope :unresolved, -> { where(resolved: false) }

    def coordinates_changed?
      return false if latitude.zero? || longitude.zero?
      latitude_changed? || longitude_changed?
    end
  end
end

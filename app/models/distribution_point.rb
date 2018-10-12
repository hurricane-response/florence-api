class DistributionPoint < ApplicationRecord
  include Geocodable

  default_scope { where(archived: false) }

  ColumnNames = %w[
    id active facility_name phone address city county state zip updated_by updated_at
    source latitude longitude google_place_id archived
  ].freeze

  # columns to hide in index view
  IndexHiddenColumnNames = %w[
    active
    google_place_id
    latitude
    longitude
    notes
  ].freeze

  HeaderNames = ColumnNames.map(&:titleize).freeze

  UpdateFields = %w[
    active facility_name phone address city county state zip notes source updated_by
    distribution_center latitude longitude google_place_id
  ].freeze

  PrivateFields = %w[archived].freeze

  AdminColumnNames = (ColumnNames + PrivateFields).freeze
  AdminUpdateFields = (UpdateFields + PrivateFields).freeze

  # columns for the outdated shelter records report view
  OutdatedViewColumnNames = %w[
    id updated_at active facility_name phone address city county state updated_by
    latitude longitude google_place_id
  ].freeze

  has_many :drafts, as: :record

  after_commit do
    DistributionPointUpdateNotifierJob.perform_later self
  end

  scope :outdated, ->(timing = 4.hours.ago) { where("updated_at < ?", timing) }
  scope :archived, -> { unscope(:where).where(archived: true) }

  def self.to_csv
    attributes = %w[
      id updated_at active facility_name address city county state latitude longitude
    ]
    CSV.generate(headers: true) do |csv|
      csv << attributes

      self.all.each do |distribution_point|
        csv << attributes.map { |attr| distribution_point.send(attr) }
      end
    end
  end
end

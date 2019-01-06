class Shelter < ApplicationRecord
  include Geocodable
  include Trashable

  default_scope { where(archived: false) }

  enum accepting: {
    yes: 'yes',
    no: 'no',
    unknown: 'unknown'
  }

  ColumnNames = %w[
    id accepting address address_name city county state zip
    google_place_id notes allow_pets pets phone shelter source supply_needs updated_by
    volunteer_needs distribution_center food_pantry updated_at latitude
    longitude accessibility unofficial
  ].freeze

  # columns to hide in index view
  IndexHiddenColumnNames = %w[
    address_name
    allow_pets
    google_place_id
    latitude
    longitude
    notes
    special_needs
  ].freeze

  HeaderNames = ColumnNames.map(&:titleize).freeze

  UpdateFields = %w[
    accepting address address_name city county state zip notes allow_pets pets phone
    shelter source supply_needs updated_by volunteer_needs distribution_center
    food_pantry latitude longitude google_place_id special_needs accessibility unofficial
  ].freeze

  PrivateFields = %w[
    private_notes
    private_email
    private_sms
    private_volunteer_data_mgr
  ].freeze

  AdminColumnNames = (ColumnNames + PrivateFields).freeze
  AdminUpdateFields = (UpdateFields + PrivateFields).freeze

  # columns for the outdated shelter records report view
  OutdatedViewColumnNames = %w[
    id updated_at updated_by phone accepting address address_name
    city county state zip google_place_id notes allow_pets pets shelter
    source supply_needs volunteer_needs distribution_center food_pantry
    latitude longitude accessibility unofficial
  ].freeze

  CSV_Attributes = %w[
    shelter address city state county zip phone updated_at source accepting pets
  ].freeze

  has_many :drafts, as: :record

  after_commit on: %i[create update] do
    ShelterUpdateNotifierJob.perform_later self
  end

  scope :outdated, ->(timing = 4.hours.ago) { where('updated_at < ?', timing) }
  scope :archived, -> { unscope(:where).where(archived: true) }

  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << CSV_Attributes

      all.each do |shelter|
        csv << CSV_Attributes.map { |attr| shelter.send(attr) }
      end
    end
  end

  def name
    shelter
  end

  def outdated?
    updated_at < 4.hours.ago
  end
end

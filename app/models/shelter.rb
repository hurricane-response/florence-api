class Shelter < ApplicationRecord
  ColumnNames = %w[
    id accepting address address_name city county state zip
    google_place_id notes allow_pets pets phone shelter source supply_needs updated_by
    volunteer_needs distribution_center food_pantry updated_at latitude
    longitude special_needs unofficial
  ]

  # columns to hide in index view
  IndexHiddenColumnNames = %w[
    address_name
    allow_pets
    google_place_id
    latitude
    longitude
    notes
  ]

  HeaderNames = ColumnNames.map(&:titleize)

  UpdateFields = %w[
    accepting address address_name city county state zip notes allow_pets pets phone
    shelter source supply_needs updated_by volunteer_needs distribution_center
    food_pantry latitude longitude google_place_id special_needs unofficial
  ]

  PrivateFields = %w[
    private_notes
    private_email
    private_sms
    private_volunteer_data_mgr
  ]

  # columns for the outdated shelter records report view
  OutdatedViewColumnNames = %w[
    id updated_at updated_by phone accepting address address_name
    city county state zip google_place_id notes allow_pets pets shelter
    source supply_needs volunteer_needs distribution_center food_pantry
    latitude longitude special_needs unofficial
  ]

  has_many :drafts, as: :record
  default_scope { where(active: !false) }

  geocoded_by :address

  after_commit do
    ShelterUpdateNotifierJob.perform_later self
  end

  scope :outdated, ->(timing = 4.hours.ago) { where("updated_at < ?", timing) }

  def self.to_csv
    attributes = %w[
      shelter address city county state zip phone updated_at source accepting pets
    ]
    CSV.generate(headers: true) do |csv|
      csv << attributes

      self.all.each do |shelter|
        csv << attributes.map { |attr| shelter.send(attr) }
      end
    end
  end
end

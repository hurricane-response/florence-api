class CharitableOrganization < ApplicationRecord
  ColumnNames = %w(name services food_bank donation_website phone_number email physical_address city state zip)

  HeaderNames = ColumnNames.map(&:titleize)

  UpdateFields = %w(name services food_bank donation_website phone_number email physical_address city state zip)

  default_scope { where(active: true) }

  has_many :drafts, as: :record

end

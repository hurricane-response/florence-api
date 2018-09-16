class Draft < ApplicationRecord
  belongs_to :record, polymorphic: true, optional: true
  belongs_to :accepted_by, class_name: 'User', optional: true
  belongs_to :denied_by, class_name: 'User', optional: true
  belongs_to :created_by, class_name: 'User', optional: true

  scope :actionable, -> { where(accepted_by_id: nil, denied_by_id: nil) }
  scope :actionable_by_type, ->(type) do
    actionable.includes(:record)
              .where("record_type = ? OR info->>'record_type' = ?", type, type)
  end
  scope :actionable_by_legacy_table, ->(org, table) do
    actionable.includes(:record)
              .where("info->>'organization' = ? AND info->>'legacy_table_name' = ?", org, table)
  end
end

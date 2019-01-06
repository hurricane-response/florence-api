class Draft < ApplicationRecord
  belongs_to :record, polymorphic: true, optional: true
  belongs_to :accepted_by, class_name: 'User', optional: true
  belongs_to :denied_by, class_name: 'User', optional: true
  belongs_to :created_by, class_name: 'User', optional: true

  scope :actionable, -> { where(accepted_by_id: nil, denied_by_id: nil) }

  def self.actionable_by_type(type)
    actionable.includes(:record)
              .where("record_type = ? OR info->>'record_type' = ?", type, type)
  end

  def self.actionable_by_legacy_table(org, table)
    actionable.includes(:record)
              .where("info->>'organization' = ? AND info->>'legacy_table_name' = ?", org, table)
  end

  def build_record
    record_info = info.delete_if { |k, _| k == 'record_type' }
    if record
      record.assign_attributes(record_info)
    else
      # Gotcha: Must have self.record or record will not initialize properly
      self.record = record_type.constantize.new(record_info)
    end
    record
  end

  def deny(user)
    update(denied_by: user)
  end

  def accept(user)
    build_record
    update(record: record, accepted_by: user) if record.save
  end
end

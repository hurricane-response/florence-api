class Draft < ApplicationRecord
  belongs_to :record, polymorphic: true, optional: true
  belongs_to :accepted_by, class_name: 'User', optional: true
  belongs_to :denied_by, class_name: 'User', optional: true
end

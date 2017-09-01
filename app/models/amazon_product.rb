class AmazonProduct < ApplicationRecord

  validates :need, presence: true
  validates :asin, presence: true
  validates :detail_url, presence: true

  scope :active, -> { where(disabled: false)}
end

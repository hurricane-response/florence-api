class AmazonProduct < ApplicationRecord

  ColumnNames = ["need", "asin", "amazon_title", "detail_url", "priority", "disabled"]

  HeaderNames = ColumnNames.map(&:titleize)

  UpdateFields = ["need", "asin", "amazon_title", "detail_url", "priority", "disabled"]


  validates :need, presence: true
  validates :asin, presence: true
  validates :detail_url, presence: true

  scope :active, -> { where(disabled: false).proper_categories.proper_pricing}
  scope :priority, -> { where(priority: true)}
  scope :proper_categories, -> {where("category_general != ? and category_specific !=?", "", "")}
  scope :proper_pricing, -> { where("price_in_cents > 0")}
end

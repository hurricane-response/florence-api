class AmazonProduct < ApplicationRecord
  ColumnNames = %w[need asin amazon_title detail_url priority disabled].freeze

  HeaderNames = ColumnNames.map(&:titleize).freeze

  UpdateFields = %w[need asin amazon_title detail_url priority disabled].freeze

  validates :need, presence: true
  validates :asin, presence: true
  validates :detail_url, presence: true

  scope :active, -> { where(disabled: false).proper_categories.proper_pricing }
  scope :priority, -> { where(priority: true) }
  scope :proper_categories, -> { where.not(category_general: '', category_specific: '') }
  scope :proper_pricing, -> { where(arel_table[:price_in_cents].gt(0)) }
end

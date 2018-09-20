class Page < ApplicationRecord
  validates :key, presence: true, uniqueness: true
  validates :content, presence: true

  scope :home, -> { where(key: "home")}
  scope :shelters, -> { where(key: "shelters")}
  scope :distribution_points, -> { where(key: "distribution_points")}
end

class Page < ApplicationRecord
  validates :key, presence: true, uniqueness: true
  validates :content, presence: true

  scope :home, -> { where(key: "home")}
end

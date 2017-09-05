class Page < ApplicationRecord
  validates :key, presence: true, uniqueness: true
  validates :content, presence: true
end

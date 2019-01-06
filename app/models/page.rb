class Page < ApplicationRecord
  validates :key, presence: true, uniqueness: true
  validates :content, presence: true

  # Generic Pages

  scope :home, -> { where(key: 'home') }

  # Shelters

  def self.shelters
    where(key: 'shelters').first_or_create do |page|
      page.content = '#Shelters'
    end
  end

  def self.new_shelter
    where(key: 'new_shelter').first_or_create do |page|
      page.content = '#New Shelter'
    end
  end

  def self.archived_shelters
    where(key: 'archived_shelters').first_or_create do |page|
      page.content = '#Archived Shelters'
    end
  end

  def self.shelter_drafts
    where(key: 'shelter_drafts').first_or_create do |page|
      page.content = '#Shelters Update Queue'
    end
  end

  def self.outdated_shelters
    where(key: 'outdated_shelters').first_or_create do |page|
      page.content = '#Shelters Needing Update'
    end
  end

  # Distribution Points

  def self.distribution_points
    where(key: 'distribution_points').first_or_create do |page|
      page.content = '#Distribution Points'
    end
  end

  def self.new_distribution_point
    where(key: 'new_distribution_point').first_or_create do |page|
      page.content = '#New Distribution Point'
    end
  end

  def self.archived_distribution_points
    where(key: 'archived_distribution_points').first_or_create do |page|
      page.content = '#Archived Distribution Points'
    end
  end

  def self.distribution_point_drafts
    where(key: 'distribution_point_drafts').first_or_create do |page|
      page.content = '#Distribution Points Update Queue'
    end
  end

  def self.outdated_distribution_points
    where(key: 'outdated_distribution_points').first_or_create do |page|
      page.content = '#Distribution Points Needing Update'
    end
  end

  # Needs

  def self.needs
    where(key: 'needs').first_or_create do |page|
      page.content = '#Needs'
    end
  end

  def self.new_need
    where(key: 'new_need').first_or_create do |page|
      page.content = '#New Need'
    end
  end

  def self.archived_needs
    where(key: 'archived_needs').first_or_create do |page|
      page.content = '#Archived Needs'
    end
  end

  def self.need_drafts
    where(key: 'need_drafts').first_or_create do |page|
      page.content = '#Needs Update Queue'
    end
  end
end

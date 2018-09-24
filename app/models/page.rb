class Page < ApplicationRecord
  validates :key, presence: true, uniqueness: true
  validates :content, presence: true

  # Generic Pages

  scope :home, -> { where(key: 'home') }

  # Shelters

  scope :shelters, -> do
    where(key: 'shelters').first_or_create do |page|
      page.content = '#Shelters'
    end
  end
  scope :new_shelter, -> do
    where(key: 'new_shelter').first_or_create do |page|
      page.content = '#New Shelter'
    end
  end
  scope :archived_shelters, -> do
    where(key: 'archived_shelters').first_or_create do |page|
      page.content = '#Archived Shelters'
    end
  end
  scope :shelter_drafts, -> do
    where(key: 'shelter_drafts').first_or_create do |page|
      page.content = '#Shelters Update Queue'
    end
  end
  scope :outdated_shelters, -> do
    where(key: 'outdated_shelters').first_or_create do |page|
      page.content = '#Shelters Needing Update'
    end
  end


  # Distribution Points

  scope :distribution_points, -> do
    where(key: 'distribution_points').first_or_create do |page|
      page.content = '#Distribution Points'
    end
  end

  scope :new_distribution_point, -> do
    where(key: 'new_distribution_point').first_or_create do |page|
      page.content = '#New Distribution Point'
    end
  end

  scope :archived_distribution_points, -> do
    where(key: 'archived_distribution_points').first_or_create do |page|
      page.content = '#Archived Distribution Points'
    end
  end

  scope :distribution_point_drafts, -> do
    where(key: 'distribution_point_drafts').first_or_create do |page|
      page.content = '#Distribution Points Update Queue'
    end
  end

  scope :outdated_distribution_points, -> do
    where(key: 'outdated_distribution_points').first_or_create do |page|
      page.content = '#Distribution Points Needing Update'
    end
  end
end

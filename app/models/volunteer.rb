class Volunteer < ApplicationRecord
  geocoded_by :full_address
end

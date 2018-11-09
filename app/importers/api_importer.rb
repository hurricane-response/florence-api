require 'rubygems'
require 'httparty'

class APIImporter
  include HTTParty
  base_uri "https://hurricane-florence-api.herokuapp.com/api/v1"
  format :json

  def self.needs
    get('/needs')['needs']
  end

  def self.shelters
    get('/shelters')['shelters'].map do |shelter|
      shelter['allow_pets'] = if shelter['pets'] == 'Yes' then true
                              elsif shelter['pets'] == 'No' then false
                              end
      shelter['pets'] = shelter['pets_notes']
      shelter.except!('pets_notes')
    end
  end

  def self.distribution_points
    get('/distribution_points')['distribution_points']
  end
end

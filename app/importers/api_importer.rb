require 'rubygems'
require 'httparty'

class APIImporter
  include HTTParty
  base_uri "https://hurricane-florence-api.herokuapp.com/api/v1"
  format :json

  def self.needs
    get('/needs')["needs"]
  end

  def self.shelters
    get('/shelters')["shelters"]
  end
end

require 'rubygems'
require 'HTTParty'

class APIImporter
  include HTTParty
  base_uri "https://api.harveyneeds.org/api/v1"
  format :json

  def self.needs
    get('/needs')["needs"]
  end

  def self.shelters
    get('/shelters')["shelters"]
  end
end

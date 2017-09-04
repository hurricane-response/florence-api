class ImportSheltersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    logger.info "Starting ImportSheltersJob #{Time.now}"
    shelters = APIImporter.shelters
    shelters.each do |shelter|
      # needs and cleanPhone are derived fields
      # updatedAt is set on save to the database
      Shelter.create! shelter.except("needs", "cleanPhone", "updatedAt")
    end
    logger.info "ImportSheltersJob Complete - {#{shelters.count}}"
  end
end

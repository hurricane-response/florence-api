class ImportSheltersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    logger.info "Starting ImportSheltersJob #{Time.now}"
    shelters = APIImporter.shelters
    shelters.each do |shelter|
      # needs and cleanPhone are derived fields
      # active is a deprecated field
      # updatedAt is set on save to the database
      data = shelter.except(*%w[needs cleanPhone updatedAt])
      active = data.delete('active')
      data['archived'] ||= active.nil? ? false : !active
      Shelter.create! data
    end
    logger.info "ImportSheltersJob Complete - {#{shelters.count}}"
  end
end

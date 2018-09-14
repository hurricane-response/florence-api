class SheltersCsvExportJob < ApplicationJob
  queue_as :default

  def perform(*args)
    logger.info "Starting SheltersCsvExportJob #{Time.now}"
    csv = Shelter.to_csv
    filename = "shelters-#{Date.today}.csv"
    open(filename, 'w') { |f| f.write(csv) }
    logger.info "SheltersCsvExportJob Complete - #{filename}"
  end
end

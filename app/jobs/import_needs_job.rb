class ImportNeedsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "Starting ImportNeedsJob #{Time.now} using API"
    needs = APIImporter.needs
    needs.each do |need|
      # needs and cleanPhone are derived fields
      # updatedAt is set on save to the database
      Need.create! need.except("needs", "cleanPhone", "updatedAt")
    end
    puts "ImportNeedsJob Complete - {#{needs.count}}"

    # schedule an update, but it's throttled to 1 every 10 minutes
    ScheduleAmazonFetchJob.perform_later
  end

end

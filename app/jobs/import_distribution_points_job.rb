class ImportDistributionPointsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    logger.info "Starting ImportDistributionPointsJob #{Time.now}"
    distribution_points = APIImporter.distribution_points
    distribution_points.each do |distribution_point|
      # last_updated are derived fields
      # updatedAt is set on save to the database
      DistributionPoint.create! distribution_point.except('updatedAt', 'last_updated')
    end
    logger.info "ImportDistributionPointsJob Complete - {#{distribution_points.count}}"
  end
end

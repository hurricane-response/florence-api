class ScheduleAmazonFetchJob < ApplicationJob
  queue_as :default

  # We can get scheduled constantly, but only run once every 10 minutes
  # Drop otherwise
  throttle threshold: 1, period: 10.minutes, drop: true unless Rails.env.test?

  def perform(*args)
    Rails.logger.debug "Starting ScheduleAmazonFetchJob"

    Need
      .all
      .map(&:clean_needs)
      .flatten
      .uniq
      .reject {|need| AmazonProduct.where("need ILIKE ?", "%#{need}%").exists? }
      .reject {|need| IgnoredAmazonProductNeed.where("need ILIKE ?", "%#{need}%").exists? }
      .tap {|needs| Rails.logger.debug "ScheduleAmazonFetchJob #{needs.count}"}
      .each { |need| FetchAmazonProductJob.perform_later(need) }

    Rails.logger.debug "ScheduleAmazonFetchJob Complete"
  end
end

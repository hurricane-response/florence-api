class DistributionPointUpdateNotifierJob < ApplicationJob
  queue_as :default

  def perform distribution_point
    ShelterChannel.broadcast_to 'distribution_points', distribution_point: render(distribution_point)
  end

  def render distribution_point
    ApplicationController.render partial: 'api/v1/distribution_points/distribution_point',
                                 locals: {
                                   distribution_point: distribution_point
                                 }
  end

end

class DistributionPointChannel < ApplicationCable::Channel
  def subscribed
    stream_for 'distribution_points'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

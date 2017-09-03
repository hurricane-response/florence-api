class NeedChannel < ApplicationCable::Channel
  def subscribed
    stream_for "needs"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

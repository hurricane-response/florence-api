class ShelterChannel < ApplicationCable::Channel
  def subscribed
    stream_for "shelters"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

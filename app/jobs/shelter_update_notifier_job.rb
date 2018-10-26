class ShelterUpdateNotifierJob < ApplicationJob
  queue_as :default

  def perform(shelter)
    ShelterChannel.broadcast_to 'shelters', shelter: render(shelter)
  end

  def render(shelter)
    ApplicationController.render partial: 'api/v1/shelters/shelter',
                                 locals: {
                                   shelter: shelter
                                 }
  end
end

class NeedUpdateNotifierJob < ApplicationJob
  queue_as :default

  def perform(need)
    NeedChannel.broadcast_to 'needs', need: render(need)
  end

  def render(need)
    ApplicationController.render partial: 'api/v1/needs/need',
                                 locals: {
                                   need: need
                                 }
  end
end

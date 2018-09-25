class Api::V1::NeedsController < ApplicationController
  include FilterByParams

  before_action do
    request.format = :json
  end

  filterable_params [
    { type: :geocoords },
    { type: :text, param: :name, field: 'location_name' },
    { type: :text, param: :location_name, field: 'location_name' },
    { type: :boolean, param: :volunteers_needed, field: 'are_volunteers_needed' },
    { type: :boolean, param: :supplies_needed, field: 'are_supplies_needed' },
  ]

  def index
    @needs, @filters =
      if params[:exporter] == 'all'
        apply_filters(Need.unscope(:where))
      else
        apply_filters(Need.all)
      end
  end

  def create
    @message = nil
    @success = false

    return render status: :forbidden, json: { error: 'invalid auth token' } unless authenticate_json_api_token!

    @need = Need.new(need_update_params)

    if @need.save
      @success = true
    else
      @message = @need.errors.messages
      @need= nil
    end
    return render template: 'api/v1/needs/show'
  end

  def need_update_params
    params.require(:need).permit(Need::UpdateFields).keep_if { |_,v| v.present? }
  end
end

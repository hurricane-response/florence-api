class Api::V1::SheltersController < ApplicationController
  include FilterByParams

  before_action do
    request.format = :json
  end

  filterable_params [
    { type: :geocoords },
    { type: :text, param: :county },
    { type: :text, param: :name, field: :shelter },
    { type: :text, param: :shelter },
    { type: :boolean, param: :archived },
    { type: :boolean, param: :special_needs },
    { type: :text, param: :accessibility },
    { type: :boolean, param: :unofficial },
    {
      type: :enum,
      param: :accepting,
      enum: ['no' => :no, 'unknown' => :unknown, 'false' => :no],
      default: :yes
    }
  ]

  def index
    @shelters, @filters =
      if params[:exporter] == 'all'
        apply_filters(Shelter.unscope(:where))
      else
        apply_filters(Shelter.all)
      end
  end

  def geo
    @shelters, @filters = apply_filters(Shelter.all)
  end

  def outdated
    @outdated, @filters = apply_filters(Shelter.outdated.order('updated_at DESC'))
  end
end

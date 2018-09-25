class Api::V1::SheltersController < ApplicationController
  include FilterByParams

  before_action do
    request.format = :json
  end

  filterable_params [
    { type: :geocoords },
    { type: :text, param: :county, field: 'county' },
    { type: :text, param: :name, field: 'shelter' },
    { type: :text, param: :shelter, field: 'shelter' },
    { type: :boolean, param: :archived, field: 'archived' },
    { type: :boolean, param: :special_needs, field: 'special_needs' },
    { type: :text, param: :accessibility, field: 'accessibility' },
    { type: :boolean, param: :unofficial, field: 'unofficial' },
    {
      type: :callback,
      param: :accepting,
      fn: lambda do |query, value, filters|
        filters[:accepting] =
          case value
          when 'yes', 'no', 'unknown'
            value.to_sym
          when 'false'
            :no
          else
            :yes
          end
        query.where(accepting: filters[:accepting])
      end
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

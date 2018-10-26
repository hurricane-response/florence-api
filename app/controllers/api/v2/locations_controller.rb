class Api::V2::LocationsController < ApplicationController
  before_action :setup, except: [:routes]

  before_action do
    request.format = :json
  end

  def setup
    @organization = params[:organization]
    @legacy_table_name = params[:legacy_table_name]
    @location_class ||= Location::Whitelist.find(@organization, @legacy_table_name)
    @locations ||= Location::Whitelist.find(@organization, @legacy_table_name).all
  end

  def index
    @filters = {}

    @locations.filters.values.each do |filter|
      case filter.type
      when :coordinates
        if params[:lat].present? && params[:lon].present?
          @filters[:lon] = params[:lon]
          @filters[:lat] = params[:lat]
          @locations = @locations.near([params[:lat], params[:lon]], 100)
        end
      when :limit
        if params[:limit].to_i.positive?
          @locations = @locations.limit(params[:limit].to_i)
        end
      when :truthy
        if params[filter.name].present?
          @filters[filter.name] = params[filter.name]
          @locations =
            if filter.column
              @locations.where(filter.name => true)
            else
              @locations.where('(legacy_data->>?)::boolean', filter.name)
            end
        end
      else
        if params[filter.name].present?
          @filters[filter.name] = params[filter.name]

          # Location whitelists valid columns. No sql injection here.
          @locations =
            if filter.column
              @locations.where("#{filter.name} ILIKE ?", "%#{@filters[filter.name]}%")
            else
              @locations.where('legacy_data->>? ILIKE ?', filter.name, "%#{@filters[filter.name]}%")
            end
        end
      end
    end
  end

  def help; end

  def routes; end
end

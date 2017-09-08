class Api::V2::LocationsController < ApplicationController

  before_action do
    request.format = :json
  end

  def index
    @organization = params[:organization]
    @legacy_table_name = params[:legacy_table_name]
    @location_class ||= Location::Whitelist.find(@organization, @legacy_table_name)

    @filters = {}

    @locations_class.filters.values.each do |filter|
      case filter.type
      when :coordinates
        if params[:lat].present? && params[:lon].present?
          @filters[:lon] = params[:lon]
          @filters[:lat] = params[:lat]
          @location_class = @location_class.near([params[:lat], params[:lon]], 100)
        end
      when :limit
        if params[:limit].to_i > 0
          @location_class = @location_class.limit(params[:limit].to_i)
        end
      when :truthy
        if params[:accepting].present?
          @filters[:accepting] = params[:accepting]

          if(filter.column)
            @location_class = @location_class.where(filter.name => true)
          else
            @location_class = @location_class.where("legacy_table_data->>? = true", filter.name)
          end
        end
      else
        if params[filter.name].present?
          @filters[filter.name] = params[filter.name]
          @shelters = @shelters.where("county ILIKE ?", "%#{@filters[:county]}%")

          # Location whitelists valid columns. No sql injection here.
          if(filter.column)
            @location_class = @location_class.where("#{filter.name} ILIKE ?", "%#{@filters[filter.name]}%")
          else
            @location_class = @location_class.where("legacy_table_data->>? ILIKE ?", filter.name, "%#{@filters[filter.name]}%")
          end
        end
      end
    end
  end
end

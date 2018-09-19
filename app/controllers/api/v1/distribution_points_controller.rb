class Api::V1::DistributionPointsController < ApplicationController

  before_action do
    request.format = :json
  end

  def index
    @distribution_points, @filters = apply_params(DistributionPoint.all)
  end

  def outdated
    @distribution_points, @filters = apply_params(DistributionPoint.outdated.order('updated_at DESC'))
  end

  private

  def apply_params(distribution_points)
    filters = {}

    if params[:lat].present? && params[:lon].present?
      filters[:lon] = params[:lon]
      filters[:lat] = params[:lat]
      distribution_points = distribution_points.near([params[:lat], params[:lon]], 100)
    end

    if params[:county].present?
      filters[:county] = params[:county]
      distribution_points = distribution_points.where("county ILIKE ?", "%#{filters[:county]}%")
    end

    if params[:name].present?
      filters[:name] = params[:name]
      distribution_points = distribution_points.where("name ILIKE ?", "%#{filters[:name]}%")
    end

    if params[:active].present?
      filters[:active] = params[:active]
      distribution_points = distribution_points.where(accepting: true)
    end

    if params[:limit].to_i.positive?
      distribution_points = distribution_points.limit(params[:limit].to_i)
    end

    [distribution_points, filters]
  end
end

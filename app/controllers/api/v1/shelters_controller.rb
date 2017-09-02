class Api::V1::SheltersController < ApplicationController

  before_action do
    request.format = :json
  end

  def index
    @filters = {}
    @shelters = Shelter.all

    if params[:lat].present? && params[:lon].present?
      @filters[:lon] = params[:lon]
      @filters[:lat] = params[:lat]
      @shelters = @shelters.near([params[:lat], params[:lon]], 100)
    end

    if params[:county].present?
      @filters[:county] = params[:county]
      @shelters = @shelters.where("county ILIKE ?", "%#{@filters[:county]}%")
    end

    if params[:shelter].present?
      @filters[:shelter] = params[:shelter]
      @shelters = @shelters.where("shelter ILIKE ?", "%#{@filters[:shelter]}%")
    end

    if params[:accepting].present?
      @filters[:accepting] = params[:accepting]
      @shelters = @shelters.where(accepting: true)
    end

    if params[:limit].to_i > 0
      @shelters = @shelters.limit(params[:limit].to_i)
    end
  end

end

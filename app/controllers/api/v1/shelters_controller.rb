class Api::V1::SheltersController < ApplicationController

  def index
    @filters = {}
    @shelters = Shelter.all

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
  end

end

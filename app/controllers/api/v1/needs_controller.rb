class Api::V1::NeedsController < ApplicationController

  def index
      @filters = {}
      @needs = Need.all

      if params[:location_name].present?
        @filters[:location_name] = params[:location_name]
        @needs = @needs.where("location_name ILIKE ?", "%#{params[:location_name]}%")
      end

      if params[:volunteers_needed].present?
        @filters[:volunteers_needed] = params[:volunteers_needed]
        @needs = @needs.where(are_volunteers_needed: true)
      end

      if params[:supplies_needed].present?
        @filters[:supplies_needed] = params[:supplies_needed]
        @needs = @needs.where(are_supplies_needed: true)
      end


  end

end

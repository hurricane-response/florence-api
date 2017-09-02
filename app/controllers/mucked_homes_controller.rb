class MuckedHomesController < ApplicationController

  def index
    @muckedHomes = MuckedHome.all
  end

  def new
    @muckedHome = MuckedHome.new
  end

  def create
    if(user_signed_in? && current_user.admin?)
      @muckedHome = MuckedHome.new(mucked_home_update_params)
      if @muckedHome.save
        redirect_to @muckedHome, notice: 'muckedHome was successfully created.'
      else
        render :new
      end
    end
  end

  def mucked_home_update_params
    params.require(:muckedHome).permit(MuckedHome::UpdateFields).keep_if { |_,v| v.present? }
  end

end

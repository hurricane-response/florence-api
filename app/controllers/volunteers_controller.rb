class VolunteersController < ApplicationController
  def index
    @volunteers = Volunteer.all
  end
end

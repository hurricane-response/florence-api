class SheltersController < ApplicationController
  before_action :set_headers
  before_action :set_shelter, only: [:show, :edit, :update, :destroy]

  def index
    @shelters = Shelter.all
  end

  def new
    @shelter = Shelter.new
  end

  def create
    if(user_signed_in? && current_user.admin?)
      @shelter = Shelter.new(shelter_update_params)

      if @shelter.save
        redirect_to @shelter, notice: 'Shelter was successfully created.'
      else
        render :new
      end
    else
      draft = Draft.new(info: shelter_update_params.merge({record_type: Shelter.name}))

      if draft.save
        redirect_to draft, notice: 'Your new shelter is pending approval.'
      else
        @shelter = Shelter.new(shelter_update_params)
        render :new
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if(user_signed_in? && current_user.admin?)
      if @shelter.update(shelter_update_params)
        redirect_to @shelter, notice: 'Shelter was successfully updated.'
      else
        render :edit
      end
    else
      draft = Draft.new(record: @shelter, info: shelter_update_params)

      if draft.save
        redirect_to draft, notice: 'Your shelter update is pending approval.'
      else
        render :edit
      end
    end
  end

  def destroy
  end

  def drafts
    @drafts = Draft.includes(:record).where("record_type = ? OR info->>'record_type' = 'Shelter'", Shelter.name).where(accepted_by_id: nil).where(denied_by_id: nil)
  end

  private

  def set_headers
    @columns = Shelter::ColumnNames
    @headers = Shelter::HeaderNames
  end

  def set_shelter
    @shelter = Shelter.find(params[:id])
  end

  def shelter_update_params
    params.require(:shelter).permit(Shelter::UpdateFields).keep_if { |_,v| v.present? }
  end

end

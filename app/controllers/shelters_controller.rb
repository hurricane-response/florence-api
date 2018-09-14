class SheltersController < ApplicationController
  before_action :set_headers, except: [:index]
  before_action :set_index_headers, only: [:index]
  before_action :set_shelter, only: [:show, :edit, :update, :destroy, :archive]

  def index
    @shelters = Shelter.all
    @page = Page.shelters.first_or_initialize
  end

  def new
    @shelter = Shelter.new
  end

  def create
    if(admin?)
      @shelter = Shelter.new(shelter_update_params)

      if @shelter.save
        redirect_to shelters_path, notice: 'Shelter was successfully created.'
      else
        render :new
      end
    else
      draft = Draft.new(info: shelter_update_params, created_by: current_user, record_type: Shelter)

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
    if(admin?)
      if @shelter.update(shelter_update_params)
        redirect_to shelters_path, notice: 'Shelter was successfully updated.'
      else
        render :edit
      end
    else
      draft = Draft.new(record: @shelter, info: shelter_update_params, created_by: current_user)

      if draft.save
        redirect_to draft, notice: 'Your shelter update is pending approval.'
      else
        render :edit
      end
    end
  end

  def destroy
  end

  def archive
    if(admin?)
      @shelter.update_attributes(active: false)
      redirect_to shelters_path, notice: "Archived!"
    else
      redirect_to shelters_path, notice: "You must be an admin to archive."
    end
  end

  def drafts
    @drafts = Draft.includes(:record).where("record_type = ? OR info->>'record_type' = ?", Shelter.name, Shelter.name).where(accepted_by_id: nil).where(denied_by_id: nil)
  end

  def outdated
    @outdated = Shelter.where("updated_at < ?", 4.hours.ago).order('updated_at DESC')
    columns = Shelter::OutdatedViewColumnNames - Shelter::IndexHiddenColumnNames
    @columns = columns
    @headers = columns.map(&:titleize)
  end

  private

  # This is the definition of a beautiful hack. 1 part gross, 2 parts simplicity. Does something neat not clever.
  def set_headers
    if(admin?)
      columns = Shelter::ColumnNames + Shelter::PrivateFields
      @columns = columns
      @headers = columns.map(&:titleize)
    else
      @columns = Shelter::ColumnNames
      @headers = Shelter::ColumnNames.map(&:titleize)
    end
  end

  def set_index_headers
    if(admin?)
      columns = (Shelter::ColumnNames + Shelter::PrivateFields) - Shelter::IndexHiddenColumnNames
      @columns = columns
      @headers = columns.map(&:titleize)
    else
      columns = Shelter::ColumnNames - Shelter::IndexHiddenColumnNames
      @columns = columns
      @headers = columns.map(&:titleize)
    end
  end

  def set_shelter
    @shelter = Shelter.find(params[:id])
  end

  # TODO: Test private fields are only updatable by admin
  def shelter_update_params
    if(admin?)
      params.require(:shelter).permit(Shelter::UpdateFields + Shelter::PrivateFields).keep_if { |_,v| v.present? }
    else
      params.require(:shelter).permit(Shelter::UpdateFields).keep_if { |_,v| v.present? }
    end
  end
end

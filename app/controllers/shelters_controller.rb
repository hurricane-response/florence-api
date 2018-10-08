class SheltersController < ApplicationController
  before_action :authenticate_admin!, only: [:archive, :unarchive]
  before_action :set_headers, except: [:index]
  before_action :set_index_headers, only: [:index]
  before_action :set_shelter, only: [:show, :edit, :update, :destroy, :archive, :unarchive]

  def index
    @shelters = Shelter.all
    @page = Page.shelters.first_or_initialize

    respond_to do |format|
      format.html
      format.csv { send_data @shelters.to_csv, filename: "shelters-#{Date.today}.csv" }
    end
  end

  def new
    @shelter = Shelter.new
  end

  def create
    if admin?
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
    if admin?
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

  def archived
    @shelters = Shelter.inactive.all
    @page = Page.shelters.first_or_initialize

    respond_to do |format|
      format.html
      format.csv { send_data @shelters.to_csv, filename: "archived-shelters-#{Date.today}.csv" }
    end
  end

  def archive
    @shelter.update_attributes(active: false)
    redirect_to shelters_path, notice: 'Archived!'
  end

  def unarchive
    @shelter.update_attributes(active: true)
    redirect_to shelters_path, notice: 'Reactivated!'
  end

  def drafts
    @drafts = Draft.includes(:record).where("record_type = ? OR info->>'record_type' = ?", Shelter.name, Shelter.name).where(accepted_by_id: nil).where(denied_by_id: nil)
  end

  def csv
    render :index, format: :csv
  end

  def outdated
    @shelters = Shelter.outdated.order('updated_at DESC')
    @columns = Shelter::OutdatedViewColumnNames - Shelter::IndexHiddenColumnNames
    @headers = @columns.map(&:titleize)
  end

private

  # This is the definition of a beautiful hack. 1 part gross, 2 parts simplicity. Does something neat not clever.
  def set_headers
    @columns = (admin? ? Shelter::AdminColumnNames : Shelter::ColumnNames)
    @headers = @columns.map(&:titleize)
  end

  def set_index_headers
    @columns = (admin? ? Shelter::AdminColumnNames : Shelter::ColumnNames)
    @columns -= Shelter::IndexHiddenColumnNames
    @headers = @columns.map(&:titleize)
  end

  def set_shelter
    @shelter = Shelter.unscope(:where).find(params[:id])
  end

  # TODO: Test private fields are only updatable by admin
  def shelter_update_params
    @columns = (admin? ? Shelter::AdminUpdateFields : Shelter::UpdateFields)
    params.require(:shelter).permit(@columns).delete_if do |k, v|
      # Make sure the required name field is not deleted
      k == 'shelter' && v.blank?
    end
  end
end

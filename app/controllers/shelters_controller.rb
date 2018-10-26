class SheltersController < ApplicationController
  before_action :authenticate_admin!, only: %i[archive unarchive destroy]
  before_action :authenticate_user!, only: [:mark_current]
  before_action :set_headers, except: [:index]
  before_action :set_index_headers, only: [:index]
  before_action :set_shelter, only: %i[show edit update destroy archive unarchive mark_current]

  def index
    @page = Page.shelters
    @shelters = Shelter.all

    respond_to do |format|
      format.html
      format.csv { send_data @shelters.to_csv, filename: "shelters-#{Date.today}.csv" }
    end
  end

  def new
    @page = Page.new_shelter
    @shelter = Shelter.new
  end

  def create
    draft_params = shelter_update_params
    draft = Draft.create(record_type: Shelter, info: draft_params, created_by: current_user)

    if draft
      if admin? && draft.accept(current_user)
        @shelter = draft.record
        redirect_to shelters_path, notice: 'Shelter was successfully created.'
      else
        redirect_to draft, notice: 'Your new shelter is pending approval.'
      end
    else
      flash[:notice] = 'Something went wrong.'
      @shelter = Shelter.new(draft_params)
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    draft = Draft.create(record: @shelter, info: shelter_update_params, created_by: current_user)

    if draft
      if admin? && draft.accept(current_user)
        redirect_to shelters_path, notice: 'Shelter was successfully updated.'
      else
        redirect_to draft, notice: 'Your shelter update is pending approval.'
      end
    else
      flash[:notice] = 'Something went wrong.'
      render :edit
    end
  end

  def destroy
    if @shelter.trash!(current_user, params[:reason])
      redirect_to shelters_path, notice: "'#{@shelter.shelter}' has been moved to the trash."
    else
      redirect_to @shelter, notice: "Something went wrong, '#{@shelter.shelter}' has not been trashed."
    end
  end

  def archived
    @page = Page.archived_shelters
    @shelters = Shelter.archived.all

    respond_to do |format|
      format.html
      format.csv { send_data @shelters.to_csv, filename: "archived-shelters-#{Date.today}.csv" }
    end
  end

  def archive
    @shelter.update_attributes(archived: true)
    redirect_to shelters_path, notice: 'Archived!'
  end

  def unarchive
    @shelter.update_attributes(archived: false)
    redirect_to archived_shelters_path, notice: 'Reactivated!'
  end

  def drafts
    @page = Page.shelter_drafts
    @drafts = Draft.actionable_by_type(Shelter.name)
  end

  def csv
    render :index, format: :csv
  end

  def outdated
    @page = Page.outdated_shelters
    @shelters = Shelter.outdated.order('updated_at DESC')

    @columns = Shelter::OutdatedViewColumnNames - Shelter::IndexHiddenColumnNames
    @headers = @columns.map(&:titleize)
  end

  def mark_current
    @shelter.update_columns(updated_at: Time.now)
    redirect_to outdated_shelters_path
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

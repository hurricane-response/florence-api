class DistributionPointsController < ApplicationController
  before_action :set_headers, except: [:index]
  before_action :set_index_headers, only: [:index]
  before_action :set_distribution_point, only: [:show, :edit, :update, :destroy, :archive, :unarchive]

  def index
    @distribution_points = DistributionPoint.all
    @page = Page.distribution_points.first_or_initialize
    respond_to do |format|
      format.html
      format.csv { send_data @distribution_points.to_csv, filename: "distribution_points-#{Date.today}.csv" }
    end
  end

  def new
    @distribution_point = DistributionPoint.new
  end

  def create
    if admin?
      @distribution_point = DistributionPoint.new(distribution_point_params)

      if @distribution_point.save
        redirect_to distribution_points_path, notice: 'Distribution Point was successfully created.'
      else
        render :new
      end
    else
      draft = Draft.new(info: distribution_point_params, created_by: current_user, record_type: DistributionPoint)

      if draft.save
        redirect_to draft, notice: 'Your new distribution point is pending approval.'
      else
        @distribution_point = DistributionPoint.new(distribution_point_params)
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
      if @distribution_point.update(distribution_point_params)
        redirect_to distribution_points_path, notice: 'Distribution Point was successfully updated.'
      else
        render :edit
      end
    else
      draft = Draft.new(record: @distribution_point, info: distribution_point_params, created_by: current_user)

      if draft.save
        redirect_to draft, notice: 'Your distribution point update is pending approval.'
      else
        render :edit
      end
    end
  end

  def destroy
  end

  def archive
    if admin?
      @distribution_point.update_attributes(archived: true)
      redirect_to distribution_points_path, notice: 'Archived!'
    else
      redirect_to distribution_points_path, notice: 'You must be an admin to archive.'
    end
  end

  def unarchive
    if admin?
      @distribution_point.update_attributes(archived: false)
      redirect_to distribution_points_path, notice: 'Unarchived!'
    else
      redirect_to distribution_points_path, notice: 'You must be an admin to unarchive.'
    end
  end

  def archived
    @distribution_points = DistributionPoint.archived.all
    @page = Page.distribution_points.first_or_initialize
    respond_to do |format|
      format.html
      format.csv { send_data @distribution_points.to_csv, filename: "archived-distribution_points-#{Date.today}.csv" }
    end
  end

  def drafts
    @drafts = Draft.includes(:record).where("record_type = ? OR info->>'record_type' = ?", DistributionPoint.name, DistributionPoint.name).where(accepted_by_id: nil).where(denied_by_id: nil)
  end

  def csv
    render :index, format: :csv
  end

  def outdated
    @distribution_points = DistributionPoint.outdated.order('updated_at DESC')
    @columns = DistributionPoint::OutdatedViewColumnNames - DistributionPoint::IndexHiddenColumnNames
    @headers = @columns.map(&:titleize)
  end

private

  # This is the definition of a beautiful hack. 1 part gross, 2 parts simplicity. Does something neat not clever.
  def set_headers
    @columns = (admin? ? DistributionPoint::AdminColumnNames : DistributionPoint::ColumnNames)
    @headers = @columns.map(&:titleize)
  end

  def set_index_headers
    @columns = (admin? ? DistributionPoint::AdminColumnNames : DistributionPoint::ColumnNames)
    @columns -= DistributionPoint::IndexHiddenColumnNames
    @headers = @columns.map(&:titleize)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_distribution_point
    @distribution_point = DistributionPoint.unscope(:where).find(params[:id])
  end

  # TODO: Test private fields are only updatable by admin
  def distribution_point_params
    @columns = (admin? ? DistributionPoint::AdminUpdateFields : DistributionPoint::UpdateFields)
    params.require(:distribution_point).permit(@columns).keep_if { |_, v| v.present? }
  end
end

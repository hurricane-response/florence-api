class DistributionPointsController < ApplicationController
  before_action :set_headers, except: [:index]
  before_action :set_index_headers, only: [:index]
  before_action :set_distribution_point, only: [:show, :edit, :update, :destroy, :archive]

  # GET /distribution_points
  # GET /distribution_points.json
  def index
    @distribution_points = DistributionPoint.all
    @page = Page.distribution_points.first_or_initialize
    respond_to do |format|
      format.html
      format.csv { send_data @distribution_points.to_csv, filename: "distribution_points-#{Date.today}.csv" }
    end
  end

  # GET /distribution_points/new
  def new
    @distribution_point = DistributionPoint.new
  end

  # GET /distribution_points/1
  # GET /distribution_points/1.json
  def show
  end

  # GET /distribution_points/1/edit
  def edit
  end

  # POST /distribution_points
  # POST /distribution_points.json
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

  # PATCH/PUT /distribution_points/1
  # PATCH/PUT /distribution_points/1.json
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

  # DELETE /distribution_points/1
  # DELETE /distribution_points/1.json
  def destroy
  end

  def archive
    if admin?
      @distribution_point.update_attributes(archived: true)
      redirect_to distribution_points_path, notice: "Archived!"
    else
      redirect_to distribution_points_path, notice: "You must be an admin to archive."
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
    @columns =
      if admin?
        DistributionPoint::ColumnNames + DistributionPoint::PrivateFields
      else
        DistributionPoint::ColumnNames
      end
    @headers = @columns.map(&:titleize)
  end

  def set_index_headers
    @columns =
      if admin?
        (DistributionPoint::ColumnNames + DistributionPoint::PrivateFields) - DistributionPoint::IndexHiddenColumnNames
      else
        DistributionPoint::ColumnNames - DistributionPoint::IndexHiddenColumnNames
      end
    @headers = @columns.map(&:titleize)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_distribution_point
    @distribution_point = DistributionPoint.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def distribution_point_params
    if admin?
      params.require(:distribution_point).permit(DistributionPoint::UpdateFields + DistributionPoint::PrivateFields).keep_if { |_,v| v.present? }
    else
      params.require(:distribution_point).permit(DistributionPoint::UpdateFields).keep_if { |_,v| v.present? }
    end
  end
end

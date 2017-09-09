class LocationsController < ApplicationController
  before_action :setup
  before_action :set_location, only: [:show, :edit, :update, :archive]

  layout "locations"

  def index
    @locations = location_class.all
  end

  def new
    @location = location_class.new()
  end

  def create
    if(user_signed_in? && current_user.admin?)
      @location = location_class.new(location_create_params)

      if @location.save
        path = location_path(organization: @organization, legacy_table_name: @legacy_table_name, id: @location.id)
        msg = "#{location_class.legacy_table_display_name} was successfully created."
        redirect_to path, notice: msg
      else
        render :new
      end
    else
      draft = Draft.new(info: location_draft_params)

      if draft.save
        path = location_draft_path(organization: @organization, legacy_table_name: @legacy_table_name, id: draft.id)
        redirect_to path, notice: 'Your new location is pending approval.'
      else
        @location = location_class.new(location_update_params)
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
      if @location.update(location_update_params)
        path = location_path(organization: @organization, legacy_table_name: @legacy_table_name, id: @location.id)
        redirect_to path, notice: "#{location_class.legacy_table_display_name} was successfully updated."
      else
        render :edit
      end
    else
      draft = Draft.new(record: @location, info: location_draft_params)

      if draft.save
        path = location_draft_path(organization: @organization, legacy_table_name: @legacy_table_name, id: draft.id)
        redirect_to path, notice: "#{location_class.legacy_table_display_name} update is pending approval."
      else
        render :edit
      end
    end
  end

  def archive
    path = locations_path(organization: @organization, legacy_table_name: @legacy_table_name)

    if(user_signed_in? && current_user.admin?)
      @location.update_attributes(active: false)
      redirect_to path, notice: "Archived!"
    else
      redirect_to path, notice: "You must be an admin to archive."
    end
  end

  def drafts
    @drafts = Draft.includes(:record).
      where("info->>'organization' = ?", @organization).
      where("info->>'legacy_table_name' = ?", @legacy_table_name).
      where(accepted_by_id: nil).
      where(denied_by_id: nil)
    @locations = location_class.where(id: @drafts.map(&:record_id)).index_by(&:id)
  end

  private

  def setup
    @organization = params[:organization]
    @legacy_table_name = params[:legacy_table_name]

    return redirect_to(root_path, notice: "No such organization and table") if !location_class.present?

    @legacy_table_display_name = location_class.legacy_table_display_name
    @update_fields = location_class.update_fields

    # TODO Add support for private fields
    # TODO Show default columns too
    @columns = location_class.table_columns
    @headers = location_class.table_headers
  end

  def location_class
    @location_class ||= Location::Whitelist.find(@organization, @legacy_table_name)
  end

  def set_location
    @location = location_class.find(params[:id])

    return redirect_to(root_path, notice: "No location for organization and table") if !@location.present?
  end

  def location_update_params
    format_params.keep_if { |_,v| v.present? }
  end

  def location_create_params
    location_update_params.merge({organization: @organization, legacy_table_name: @legacy_table_name})
  end

  def location_draft_params
    location_create_params
  end

  def format_params
    key = location_class.name.gsub('::','').underscore
    location_class.update_fields.each_with_object({}) do |field,obj|
      value = params[key][field.name]
      if(value)
        obj[field.name] = location_class.format_field(field.type, value)
      end
    end
  end
end

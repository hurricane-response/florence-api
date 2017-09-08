class LocationDraftsController < ApplicationController
  before_action :authenticate_admin!, only: [:destroy, :accept]
  before_action :set_record

  layout "locations"

  def show
    @columns = @record.class.table_columns
    @headers = @record.class.table_headers
  end

  def destroy
    @draft.update(denied_by: current_user)
    if(@draft.record.present?)
      path = location_path(organization: @organization, legacy_table_name: @legacy_table_name, id: @draft.record.id)
    else
      path = locations_path(organization: @organization, legacy_table_name: @legacy_table_name)
    end
    redirect_to path, notice: "Update was denied."
  end

  def accept
    info = @draft.info
    @record.assign_attributes(info)

    if(@record.save)
      path = location_path(organization: @record.organization, legacy_table_name: @record.legacy_table_name, id: @record.id)
      @draft.update(record: @record, accepted_by: current_user)
      redirect_to path, notice: "#{@record.class.legacy_table_display_name.singularize} updated"
    else
      flash[:notice] = "Something went wrong."
      render :edit
    end
  end

  private

  def set_record
    @draft = Draft.find(params[:id])
    @organization = @draft.info['organization']
    @legacy_table_name = @draft.info['legacy_table_name']
    if(@draft.record)
      @record = Location::Whitelist.find(@organization, @legacy_table_name).find(@draft.record_id)
    else
      @record = Location::Whitelist.find(@organization, @legacy_table_name).new
    end
  end
end

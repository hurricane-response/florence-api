class LocationDraftsController < ApplicationController
  before_action :authenticate_admin!, only: [:destroy, :accept]
  before_action :set_record

  layout 'locations'

  def show
    @columns = @record.class.table_columns
    @headers = @record.class.table_headers
  end

  def destroy
    @draft.update(denied_by: current_user)
    redirect_after_update('Update was denied.')
  end

  def accept
    info = @draft.info
    @record.assign_attributes(info)

    if @record.save
      @draft.update(record: @record, accepted_by: current_user)
      redirect_after_update("#{@record.class.legacy_table_display_name.singularize} updated")
    else
      flash[:notice] = 'Something went wrong.'
      render :edit
    end
  end

private

  def set_record
    @draft = Draft.find(params[:id])
    @organization = @draft.info['organization']
    @legacy_table_name = @draft.info['legacy_table_name']
    @record =
      if @draft.record
        Location::Whitelist.find(@organization, @legacy_table_name).find(@draft.record_id)
      else
        Location::Whitelist.find(@organization, @legacy_table_name).new
      end
  end

  def next_draft
    @next_draft ||= Draft.actionable_by_legacy_table(@organization, @legacy_table_name).first
  end

  def redirect_after_update(msg)
    if next_draft.present?
      path = location_draft_path(organization: @organization, legacy_table_name: @legacy_table_name, id: @next_draft.id)
      msg += " Redirecting to next draft in queue."
    else
      path = locations_path(organization: @organization, legacy_table_name: @legacy_table_name)
      msg += " All drafts processed. Keep up the good work and thank you."
    end

    redirect_to path, notice: msg
  end
end

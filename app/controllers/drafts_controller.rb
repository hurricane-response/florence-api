class DraftsController < ApplicationController
  before_action :authenticate_admin!, only: [:destroy, :accept]
  before_action :set_record

  def show
    @columns = @record.class::ColumnNames
    @headers = @record.class::HeaderNames
  end

  def destroy
    @draft.update(denied_by: current_user)
    redirect_to @draft.record || root_path, notice: "#{@record.class.name} update was denied."
  end

  def accept
    info = @draft.info.delete_if { |k,_| "record_type" == k }

    @record.assign_attributes(info)

    if(@record.save)
      @draft.update(record: @record, accepted_by: current_user)
      redirect_to @record, notice: "#{@record.class.name} updated"
    else
      flash[:notice] = "Something went wrong."
      render :edit
    end
  end

  private

  def set_record
    @draft = Draft.find(params[:id])
    if(@draft.record)
      @record = @draft.record
    else
      @record = @draft.info["record_type"].constantize.new
    end
  end
end

class DraftsController < ApplicationController
  before_action :authenticate_admin!, only: %i[destroy accept]
  before_action :set_record

  def show
    @record = @draft.build_record
    @columns = @record.class::ColumnNames
    @headers = @record.class::HeaderNames
  end

  def destroy
    @draft.deny(current_user)
    redirect_to (@draft.record || root_path), notice: "#{@draft.record.class.name} update was denied."
  end

  def accept
    if @draft.accept(current_user)
      @record = @draft.record
      redirect_to [:drafts, @record.class.name.underscore.pluralize.to_sym], notice: "#{@record.class.name} updated"
    else
      flash[:notice] = 'Something went wrong.'
      render :edit
    end
  end

private

  def set_record
    @draft = Draft.find(params[:id])
  end
end

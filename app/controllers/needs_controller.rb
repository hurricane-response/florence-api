class NeedsController < ApplicationController
  before_action :authenticate_admin!, only: [:archive]
  before_action :set_headers
  before_action :set_need, only: [:show, :edit, :update, :destroy, :archive]

  def index
    @page = Page.needs
    @needs = Need.all
  end

  def new
    @page = Page.new_need
    @need = Need.new
  end

  def create
    draft_params = need_update_params
    draft = Draft.create(record_type: Need, info: draft_params, created_by: current_user)

    if draft
      if admin? && draft.accept(current_user)
        @need = draft.record
        redirect_to @need, notice: 'Need was successfully created.'
      else
        redirect_to draft, notice: 'Your new need is pending approval.'
      end
    else
      flash[:notice] = "Something went wrong."
      @need = Need.new(draft_params)
      render :new
    end
  end

  def show
    @need = Need.find(params[:id])
  end

  def destroy
  end

  def edit
  end

  def update
    draft_params = need_update_params
    draft = Draft.create(record: @need, info: draft_params, created_by: current_user)

    if draft
      if admin? && draft.accept(current_user)
        redirect_to @need, notice: 'Need was successfully updated.'
      else
        redirect_to draft, notice: 'Your need update is pending approval.'
      end
    else
      flash[:notice] = 'Something went wrong.'
      render :edit
    end
  end

  def archived
    @page = Page.archived_needs
    @needs = Need.inactive.all
  end

  def archive
    @need.update_attributes(active: false)
    redirect_to needs_path, notice: 'Archived!'
  end

  def unarchive
    if admin?
      @need.update_attributes(active: true)
      redirect_to needs_path, notice: 'Reactivated!'
    else
      redirect_to needs_path, notice: 'You must be an admin to unarchive.'
    end
  end

  def drafts
    @drafts = Draft.actionable_by_type(Need.name)
  end

private

  def set_headers
    @columns = Need::ColumnNames
    @headers = Need::HeaderNames
  end

  def set_need
    @need = Need.find(params[:id])
  end

  def need_update_params
    params.require(:need).permit(Need::UpdateFields).keep_if { |_,v| v.present? }
  end
end

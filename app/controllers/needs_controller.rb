class NeedsController < ApplicationController
  before_action :authenticate_admin!, only: [:archive]
  before_action :set_headers
  before_action :set_need, only: [:show, :edit, :update, :destroy, :archive]

  def index
    @needs = Need.all
  end

  def new
    @need = Need.new
  end

  def create
    if admin?
      @need = Need.new(need_update_params)

      if @need.save
        redirect_to @need, notice: 'Need was successfully created.'
      else
        render :new
      end
    else
      draft = Draft.new(info: need_update_params.merge({record_type: Need.name}), created_by: current_user)

      if draft.save
        redirect_to draft, notice: 'Your new need is pending approval.'
      else
        @need = Need.new(need_update_params)
        render :new
      end
    end
  end

  def show
    @need = Need.find(params[:id])
  end

  def destroy
  end

  def archive
    @need.update_attributes(active: false)
    redirect_to needs_path, notice: 'Archived!'
  end

  def edit
  end

  def update
    if admin?
      if @need.update(need_update_params)
        redirect_to @need, notice: 'Need was successfully updated.'
      else
        render :edit
      end
    else
      draft = Draft.new(record: @need, info: need_update_params, created_by: current_user)

      if draft.save
        redirect_to draft, notice: 'Your need update is pending approval.'
      else
        render :edit
      end
    end
  end


  def drafts
    @drafts = Draft.includes(:record)
      .where("record_type = ? OR info->>'record_type' = 'Need'", Need.name)
      .where(accepted_by_id: nil)
      .where(denied_by_id: nil)
  end

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

class CharitableOrganizationsController < ApplicationController
  before_action :set_headers
  before_action :set_charitable_organization, only: [:show, :edit, :update, :destroy, :archive]

  def index
    @charitable_organizations = CharitableOrganization.all
  end

  def new
    @charitable_organization = CharitableOrganization.new
  end

  def create

    if(user_signed_in? && current_user.admin?)
      @charitable_organization = CharitableOrganization.new(charitable_organization_update_params)

      if @charitable_organization.save
        redirect_to @charitable_organization, notice: 'Charitable Organization was successfully created.'
      else
        render :new
      end
    else
      draft = Draft.new(info: charitable_organization_update_params, record_type: CharitableOrganization, created_by: current_user)

      if draft.save
        redirect_to draft, notice: 'Your new Charitable Organization is pending approval.'
      else
        @charitable_organization = CharitableOrganization.new(charitable_organization_update_params)
        render :new
      end
    end
  end

  def show
    @charitable_organization = CharitableOrganization.find(params[:id])
  end

  def destroy
  end

  def archive
    if(user_signed_in? && current_user.admin?)
      @charitable_organization.update_attributes(active: false)
      redirect_to charitable_organizations_path, notice: "Archived!"
    else
      redirect_to charitable_organizations_path, notice: "You must be an admin to archive."
    end
  end

  def edit
  end

  def update
    if(user_signed_in? && current_user.admin?)
      if @charitable_organization.update(charitable_organization_update_params)
        redirect_to @charitable_organization, notice: 'Charitable Organization was successfully updated.'
      else
        render :edit
      end
    else
      draft = Draft.new(record: @charitable_organization, info: charitable_organization_update_params, created_by: current_user)

      if draft.save
        redirect_to draft, notice: 'Your Charitable Organization update is pending approval.'
      else
        render :edit
      end
    end
  end


  def drafts
    @drafts = Draft.includes(:record).where("record_type = ? OR info->>'record_type' = 'CharitableOrganization'", CharitableOrganization.name).where(accepted_by_id: nil).where(denied_by_id: nil)
  end

  def set_headers
    @columns = CharitableOrganization::ColumnNames
    @headers = CharitableOrganization::HeaderNames
  end

  def set_charitable_organization
    @charitable_organization = CharitableOrganization.find(params[:id])
  end

  def charitable_organization_update_params
    params.require(:charitable_organization).permit(CharitableOrganization::UpdateFields).keep_if { |_,v| v.present? }
  end

end

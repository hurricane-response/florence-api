class OrganizationsController < ApplicationController
  layout 'locations'

  def show
    @organization = params[:organization]
    @organization_tables = Location::Whitelist.organization_tables(@organization)
    redirect_to root_path unless @organization_tables.present?
  end
end

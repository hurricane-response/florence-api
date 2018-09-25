class Api::V1::CharitableOrganizationsController < ApplicationController
  include FilterByParams

  before_action do
    request.format = :json
  end

  filterable_params [
    { type: :text, param: :services },
    { type: :text, param: :name },
    { type: :boolean, param: :food_bank },
    { type: :text, param: :city },
  ]

  def index
    @charitable_organizations, @filters = apply_filters(CharitableOrganization.all)
  end
end

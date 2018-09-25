class Api::V1::CharitableOrganizationsController < ApplicationController
  include FilterByParams

  before_action do
    request.format = :json
  end

  filterable_params [
    { type: :text, param: :services, field: 'services' },
    { type: :text, param: :name, field: 'name' },
    { type: :boolean, param: :food_bank, field: 'food_bank' },
    { type: :text, param: :city, field: 'city' },
  ]

  def index
    @charitable_organizations, @filters = apply_filters(CharitableOrganization.all)
  end
end

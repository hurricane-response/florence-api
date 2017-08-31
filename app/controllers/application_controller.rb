class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action do
    request.format = :json
  end
end

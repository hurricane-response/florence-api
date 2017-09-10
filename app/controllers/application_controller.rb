class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action do
    @application_name = ENV.fetch('CANONICAL_NAME', 'Disaster API')
  end

  def admin?
    user_signed_in? && current_user.admin?
  end

  def json_api_token_auth?
    request.headers['Authorization'] == "Bearer #{ENV['JSON_API_KEY']}"
  end

  def authenticate_admin!
    if !admin?
      redirect_to request.referrer || root_path, notice: "Admins Only! :|"
    end
  end
end

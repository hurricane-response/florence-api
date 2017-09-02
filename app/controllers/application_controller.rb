class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def authenticate_admin!
    if !(user_signed_in? && current_user.admin?)
      redirect_to request.referrer || root_path, notice: "Admins Only! :|"
    end
  end
end

class UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(admin: params[:admin])

    redirect_to @user, notice: "User is now #{@user.admin? ? "" : "not"} an admin."
  end
end

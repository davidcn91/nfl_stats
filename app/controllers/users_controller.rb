class UsersController < ApplicationController

  def index
    authorize_user
    @users = User.order(:first_name)
  end

  def destroy
    authorize_user
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  protected

  def authorize_user
    if !user_signed_in? || !current_user.admin?
      raise ActionController::RoutingError.new("Not Found")
    end
  end

end

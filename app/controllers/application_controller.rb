class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_constants

  def set_constants
    @season_collection = Game::SEASONS
    @team_collection = Team.pluck(:name).sort
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:first_name, :last_name, :email, :password, :password_confirmation, :team_id)
    end

    devise_parameter_sanitizer.permit(:account_update) { |u|
      u.permit(:first_name, :last_name, :email, :password, :password_confirmation,
      :current_password, :team_id)
    }
  end
end

class TeamsController < ApplicationController

  def index
  end

  protected
  def team_params
    params.require(:team).permit(:location, :name, :abbreviation)
  end

end

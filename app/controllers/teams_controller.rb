class TeamsController < ApplicationController

  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
  end

  protected
  def team_params
    params.require(:team).permit(:location, :name, :abbreviation)
  end

end

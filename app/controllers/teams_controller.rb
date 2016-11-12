class TeamsController < ApplicationController

  def index
    @teams = Team.all
  end

  def show
    if params[:id] == "dropdown_selection"
      @team = Team.where(name: params[:teams][:name])[0]
    else
      @team = Team.find(params[:id])
    end
    @team_name = @team.name
    away_games = Game.where(away_team_id: @team.id)
    home_games = Game.where(home_team_id: @team.id)
    @games = ((away_games + home_games).sort_by { |g| [g.season, g.week] }).reverse
  end

  protected
  def team_params
    params.require(:team).permit(:location, :name, :abbreviation)
  end

end

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
    @games = ((@team.away_games + @team.home_games).sort_by { |g| [g.season, g.week] }).reverse
  end

  protected
  def team_params
    params.require(:team).permit(:location, :name, :abbreviation)
  end

end

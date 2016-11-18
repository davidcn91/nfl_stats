class TeamsController < ApplicationController

  def index
    @teams = Team.all
    if params[:standings] || params[:standings_by_season]
      if params[:standings_by_season]
        @season = params[:standings_by_season][:season]
      else
        @season = params[:standings]
      end
      render 'standings'
    end
  end

  def show
    if params[:id] == "teams_dropdown"
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

class GamesController < ApplicationController

  def index
  end

  protected
  def game_params
    params.require(:game).permit(:season, :week, :away_team_id, :home_team_id, :away_score, :home_score, :spread)
  end

end

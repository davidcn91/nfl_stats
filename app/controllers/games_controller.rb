class GamesController < ApplicationController

  def new
    @game = Game.new
    @season_collection = Game::SEASONS
    @week_collection = Game::WEEKS
    @team_collection = Team.pluck(:name).sort
  end

  def create
    @season_collection = Game::SEASONS
    @week_collection = Game::WEEKS
    @team_collection = Team.pluck(:name).sort
    @game = Game.new(game_params)
    if !params[:game][:away_team_id].empty? && !params[:game][:home_team_id].empty?
      @game.away_team_id = Team.where(name: params[:game][:away_team_id])[0].id
      @game.home_team_id = Team.where(name: params[:game][:home_team_id])[0].id
    end
    if !user_signed_in?
      flash[:notice] = "You must be signed in to add a game."
      render :new
    elsif @game.save
      flash[:notice] = "Game added successfully!"
      redirect_to teams_path
    else
      render :new
    end
  end

  protected
  def game_params
    params.require(:game).permit(:season, :week, :away_team_id, :home_team_id, :away_score, :home_score, :spread)
  end

end

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
    else
      @game.user_id = current_user.id
      if @game.save
        flash[:notice] = "Game added successfully!"
        redirect_to teams_path
      else
        render :new
      end
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  def destroy
    @game = Game.find(params[:id])
    authorize_user(@game)
    @game.destroy
    flash[:notice] = "Game deleted successfully."
    redirect_to teams_path
  end

  protected
  def game_params
    params.require(:game).permit(:season, :week, :away_team_id, :home_team_id, :away_score, :home_score, :spread)
  end

  def authorize_user(game)
    if !user_signed_in? || (!current_user.admin? && (current_user.id != game.user_id))
      raise ActionController::RoutingError.new("Not Found")
    end
  end

end

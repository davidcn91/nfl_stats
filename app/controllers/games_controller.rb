class GamesController < ApplicationController

  def index
    if params[:season]
      @seasons = [params[:season].to_i]
    elsif params[:Season] && (params[:Season][:season] != "2001-2016")
      @seasons = [params[:Season][:season].to_i]
    else
      @seasons = @season_collection
    end
    if @seasons == @season_collection
      @games = Game.all
    else
      @games = Game.where(season: @seasons[0])
    end
    if @seasons.nil? || (@seasons.length > 1)
      @season_selected = "2001-2016"
    else
      @season_selected = @seasons[0]
    end
  end

  def new
    @game = Game.new
    @week_collection = Game::WEEKS
    @team_collection = Team.pluck(:name).sort
  end

  def create
    @week_collection = Game::WEEKS
    @team_collection = Team.pluck(:name).sort
    @game = Game.new(game_params)
    if !params[:game][:away_team_id].empty?
      @game.away_team_id = Team.where(name: params[:game][:away_team_id])[0].id
    end
    if !params[:game][:home_team_id].empty?
      @game.home_team_id = Team.where(name: params[:game][:home_team_id])[0].id
    end
    if !user_signed_in?
      flash[:notice] = "You must be signed in to add a game."
      render :new
    else
      @game.user_id = current_user.id
      if @game.save
        flash[:notice] = "Game added successfully!"
        redirect_to new_game_stat_path(@game.id)
      else
        if !@game.away_team.nil?
          @away_team = @game.away_team.name
        end
        if !@game.home_team.nil?
          @home_team = @game.home_team.name
        end
        render :new
      end
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  def edit
    @game = Game.find(params[:id])
    authorize_user(@game)
    @header_season = @game.season
    @header_week = @game.week
    @header_away_team = @game.away_team
    @header_home_team = @game.home_team
    @header_away_score = @game.away_score
    @header_home_score = @game.home_score
    @header_overtime = @game.overtime
    @away_team = @game.away_team.name
    @home_team = @game.home_team.name
    @week_collection = Game::WEEKS
    @team_collection = Team.pluck(:name).sort
  end

  def update
    @game = Game.find(params[:id])
    authorize_user(@game)
    @header_season = @game.season
    @header_week = @game.week
    @header_away_team = @game.away_team
    @header_home_team = @game.home_team
    @header_away_score = @game.away_score
    @header_home_score = @game.home_score
    @header_overtime = @game.overtime
    @week_collection = Game::WEEKS
    @team_collection = Team.pluck(:name).sort
    @game.update(game_params)
    if !params[:game][:away_team_id].empty?
      @game.away_team_id = Team.where(name: params[:game][:away_team_id])[0].id
    end
    if !params[:game][:home_team_id].empty?
      @game.home_team_id = Team.where(name: params[:game][:home_team_id])[0].id
    end
    if @game.save
      flash[:notice] = "Game updated successfully!"
      redirect_to game_path(@game.id)
    else
      if !@game.away_team.nil?
        @away_team = @game.away_team.name
      end
      if !@game.home_team.nil?
        @home_team = @game.home_team.name
      end
      render :edit
    end
  end

  def destroy
    @game = Game.find(params[:id])
    authorize_user(@game)
    @game.destroy
    flash[:notice] = "Game deleted successfully!"
    redirect_to teams_path
  end

  protected
  def game_params
    params.require(:game).permit(:season, :week, :away_team_id, :home_team_id, :away_score, :home_score, :overtime, :spread)
  end

  def authorize_user(game)
    if !user_signed_in? || (!current_user.admin? && (current_user.id != game.user_id))
      raise ActionController::RoutingError.new("Not Found")
    end
  end

end

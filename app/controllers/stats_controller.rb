class StatsController < ApplicationController

  def new
    @game = Game.find(params[:game_id])
    authorize_user(@game)
    @stat = Stat.new
  end

  def create
    @game = Game.find(params[:game_id])
    @stat = Stat.new(stat_params)
    if !user_signed_in?
      flash[:notice] = "You must be signed in to add game stats."
      render :new
    else
      @stat.game_id = @game.id
      if @stat.save
        flash[:notice] = "Game stats added successfully!"
        redirect_to game_path(@game.id)
      else
        render :new
      end
    end
  end

<<<<<<< HEAD
  def edit
    @game = Game.find(params[:game_id])
    @stat = Stat.find(params[:id])
    authorize_user(@game)
  end

  def update
    @game = Game.find(params[:game_id])
    @stat = Stat.find(params[:id])
    authorize_user(@game)
    @stat.update(stat_params)
    @stat.game_id = @game.id
    if @stat.save
      flash[:notice] = "Game stats updated successfully!"
      redirect_to game_path(@game.id)
    else
      render :edit
    end
=======
  def destroy
    @game = Game.find(params[:game_id])
    @stat = Stat.find(params[:id])
    authorize_user(@game)
    @stat.destroy
    flash[:notice] = "Game stats deleted successfully!"
    redirect_to teams_path
>>>>>>> stats
  end


  protected

  def stat_params
    params.require(:stat).permit(:away_plays, :away_yards, :away_third_down_conversions, :away_third_down_attempts,
    :away_penalties, :away_penalty_yards, :away_rushes, :away_rushing_yards, :away_passes, :away_completions,
    :away_passing_yards, :away_time_of_possession, :away_fumbles, :away_fumbles_lost, :away_interceptions,
    :home_plays, :home_yards, :home_third_down_conversions, :home_third_down_attempts,
    :home_penalties, :home_penalty_yards, :home_rushes, :home_rushing_yards, :home_passes, :home_completions,
    :home_passing_yards, :home_time_of_possession, :home_fumbles, :home_fumbles_lost, :home_interceptions)
  end

  def authorize_user(game)
    if !user_signed_in? || (!current_user.admin? && (current_user.id != game.user_id))
      raise ActionController::RoutingError.new("Not Found")
    end
  end

end

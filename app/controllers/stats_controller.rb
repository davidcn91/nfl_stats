class StatsController < ApplicationController

  def index
    if params[:side].nil?
      @side = "offense"
    else
      @side = params[:side]
    end
    @sort = params[:sort]
    if @sort.nil?
      @teams = Team.all
    else
      if (@sort == params[:current_sort]) && params[:order] == "desc"
        @order = "asc"
      else
        @order = "desc"
      end
      if ["name", "games"].include?(@sort)
        @teams = Team.all.sort_by {|team| (team.send(@sort))}
      else
        @teams = Team.all.sort_by {|team| (team.send(@sort,(@side)))}
      end
      if @order == "desc"
        @teams.reverse!
      end
      if @sort == "name"
        @teams.reverse!
      end
    end

    @categories = [["Team","name"],["G","games"],["Points","points"],["Pts/Gm","points_per_game"],
  ["Plays","plays"],["Plays/Gm","plays_per_game"],["Yards","yards"],["Yds/Gm","yards_per_game"],["Yds/Play","yards_per_play"],
["3rd Conv","third_down_conversions"],["3rd Att","third_down_attempts"],["3rd Pct","third_down_percentage"],
["Penalties","penalties"],["Pen Yards","penaty_yards"],["Pen Yds/G","penalty_yards_per_game"],["Fumbles","fumbles"],
["Fum Lost","fumbles_lost"],["INT","interceptions"],["Turnovers","turnovers"],["TO/G","turnovers_per_game"]]
  end

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

  def edit
    @game = Game.find(params[:game_id])
    authorize_user(@game)
    @stat = Stat.find(params[:id])
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
  end

  protected

  def stat_params
    params.require(:stat).permit(:away_plays, :away_yards, :away_third_down_conversions, :away_third_down_attempts,
    :away_penalties, :away_penalty_yards, :away_rushes, :away_rushing_yards, :away_passes, :away_completions,
    :away_passing_yards, :away_time_of_possession, :away_fumbles, :away_fumbles_lost, :away_interceptions,
    :home_plays, :home_yards, :home_third_down_conversions, :home_third_down_attempts, :home_completions,
    :home_penalties, :home_penalty_yards, :home_rushes, :home_rushing_yards, :home_passes,
    :home_passing_yards, :home_time_of_possession, :home_fumbles, :home_fumbles_lost, :home_interceptions)
  end

  def authorize_user(game)
    if !user_signed_in? || (!current_user.admin? && (current_user.id != game.user_id))
      raise ActionController::RoutingError.new("Not Found")
    end
  end

end

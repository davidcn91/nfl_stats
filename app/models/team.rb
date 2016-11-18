class Team < ActiveRecord::Base
  validates :location, :name, :abbreviation, presence: true
  validates :name, :abbreviation, uniqueness: true
  validates :abbreviation, length: { minimum: 2, maximum: 3}

  has_many :away_games, class_name: 'Game', foreign_key: 'away_team_id'
  has_many :home_games, class_name: 'Game', foreign_key: 'home_team_id'
  has_many :users

  DIVISIONS = ["NFC East", "NFC North", "NFC South", "NFC West",
  "AFC East", "AFC North", "AFC South", "AFC West"]

  def game_stats(season)
    games = []
    (away_games + home_games).each do |game|
      if !game.stat.nil? && ((game.season == season.to_i) || season == "2001-2016")
        games << game
      end
    end
    games
  end

  def games(season)
    game_stats(season).length
  end

  def points(season,side)
    points = 0
    game_stats(season).each do |game|
      if name == game.away_team.name
        if (side == "offense")
          points += game.away_score
        else
          points += game.home_score
        end
      else
        if (side == "offense")
          points += game.home_score
        else
          points += game.away_score
        end
      end
    end
    points
  end

  def points_per_game(season,side)
    if games(season) == 0
      0
    else
      (points(season,side).to_f/games(season))
    end
  end

  def plays(season,side)
    if (side == "offense")
      calculate_stat(season,"plays")
    else
      calculate_stat_allowed(season,"plays")
    end
  end

  def plays_per_game(season,side)
    if games(season) == 0
      0
    else
      (plays(season,side).to_f/games(season))
    end
  end

  def yards(season,side)
    if (side == "offense")
      calculate_stat(season,"yards")
    else
      calculate_stat_allowed(season,"yards")
    end
  end

  def yards_per_game(season,side)
    if games(season) == 0
      0
    else
      (yards(season,side).to_f/games(season))
    end
  end

  def yards_per_play(season,side)
    if plays(season,side) == 0
      0
    else
      (yards(season,side).to_f/plays(season,side))
    end
  end

  def rushes(season, side)
    if (side == "offense")
      calculate_stat(season,"rushes")
    else
      calculate_stat_allowed(season,"rushes")
    end
  end

  def rushing_yards(season, side)
    if (side == "offense")
      calculate_stat(season,"rushing_yards")
    else
      calculate_stat_allowed(season,"rushing_yards")
    end
  end

  def rushing_yards_per_game(season,side)
    if games(season) == 0
      0
    else
      (rushing_yards(season,side).to_f/games(season))
    end
  end

  def yards_per_rush(season,side)
    if rushes(season,side) == 0
      0
    else
      (rushing_yards(season,side).to_f/rushes(season,side))
    end
  end

  def completions(season, side)
    if (side == "offense")
      calculate_stat(season,"completions")
    else
      calculate_stat_allowed(season,"completions")
    end
  end

  def passes(season, side)
    if (side == "offense")
      calculate_stat(season,"passes")
    else
      calculate_stat_allowed(season,"passes")
    end
  end

  def completion_percentage(season,side)
    if passes(season,side) == 0
      0
    else
      ((completions(season,side).to_f)/passes(season,side)) * 100
    end
  end

  def passing_yards(season, side)
    if (side == "offense")
      calculate_stat(season,"passing_yards")
    else
      calculate_stat_allowed(season,"passing_yards")
    end
  end

  def passing_yards_per_game(season,side)
    if games(season) == 0
      0
    else
      (passing_yards(season,side).to_f/games(season))
    end
  end

  def yards_per_pass(season,side)
    if passes(season,side) == 0
      0
    else
      (passing_yards(season,side).to_f/passes(season,side))
    end
  end

  def third_down_conversions(season,side)
    if (side == "offense")
      calculate_stat(season,"third_down_conversions")
    else
      calculate_stat_allowed(season,"third_down_conversions")
    end
  end

  def third_down_attempts(season,side)
    if (side == "offense")
      calculate_stat(season,"third_down_attempts")
    else
      calculate_stat_allowed(season,"third_down_attempts")
    end
  end

  def third_down_percentage(season,side)
    if third_down_attempts(season,side) == 0
      0
    else
      ((third_down_conversions(season,side).to_f)/third_down_attempts(season,side)) * 100
    end
  end

  def penalties(season,side)
    if (side == "offense")
      calculate_stat(season,"penalties")
    else
      calculate_stat_allowed(season,"penalties")
    end
  end

  def penalty_yards(season,side)
    if (side == "offense")
      calculate_stat(season,"penalty_yards")
    else
      calculate_stat_allowed(season,"penalty_yards")
    end
  end

  def penalty_yards_per_game(season,side)
    if games(season) == 0
      0
    else
      (penalty_yards(season,side).to_f/games(season))
    end
  end

  def fumbles(season,side)
    if (side == "offense")
      calculate_stat(season,"fumbles")
    else
      calculate_stat_allowed(season,"fumbles")
    end
  end

  def fumbles_lost(season,side)
    if (side == "offense")
      calculate_stat(season,"fumbles_lost")
    else
      calculate_stat_allowed(season,"fumbles_lost")
    end
  end

  def interceptions(season,side)
    if (side == "offense")
      calculate_stat(season,"interceptions")
    else
      calculate_stat_allowed(season,"interceptions")
    end
  end

  def turnovers(season,side)
    fumbles_lost(season,side) + interceptions(season,side)
  end

  def turnovers_per_game(season,side)
    if games(season) == 0
      0
    else
      (turnovers(season,side).to_f/games(season))
    end
  end

  def calculate_stat(season, statistic)
    total = 0
    game_stats(season).each do |game|
      if name == game.away_team.name
        total += game.stat.send("away_#{statistic}")
      else
        total += game.stat.send("home_#{statistic}")
      end
    end
    total
  end

  def calculate_stat_allowed(season, statistic)
    total = 0
    game_stats(season).each do |game|
      if name == game.away_team.name
        total += game.stat.send("home_#{statistic}")
      else
        total += game.stat.send("away_#{statistic}")
      end
    end
    total
  end

  def record(season = "2001-2016")
    record = [0,0,0]
    if season == "2001-2016"
      team_away_games = away_games
      team_home_games = home_games
    else
      team_away_games = away_games.where(season: season)
      team_home_games = home_games.where(season: season)
    end
    team_away_games.each do |game|
      if game.away_score > game.home_score
        record[0] += 1
      elsif game.home_score > game.away_score
        record[1] += 1
      elsif game.home_score == game.away_score
        record[2] += 1
      end
    end
    team_home_games.each do |game|
      if game.home_score > game.away_score
        record[0] += 1
      elsif game.away_score > game.home_score
        record[1] += 1
      elsif game.home_score == game.away_score
        record[2] += 1
      end
    end
    record
  end

  def win_percentage(season)
    if record(season) == [0,0,0]
      0
    else
      (record(season)[0] + (record(season)[2].to_f/2))/(record(season)[0] + record(season)[1] + record(season)[2])
    end
  end

end

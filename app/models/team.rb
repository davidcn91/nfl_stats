class Team < ActiveRecord::Base
  validates :location, :name, :abbreviation, presence: true
  validates :name, :abbreviation, uniqueness: true
  validates :abbreviation, length: { minimum: 2, maximum: 3}

  has_many :away_games, class_name: 'Game', foreign_key: 'away_team_id'
  has_many :home_games, class_name: 'Game', foreign_key: 'home_team_id'
  has_many :users

  DIVISIONS = ["NFC East", "NFC North", "NFC South", "NFC West",
  "AFC East", "AFC North", "AFC South", "AFC West"]

  def game_stats
    games = []
    (away_games + home_games).each do |game|
      if !game.stat.nil?
        games << game
      end
    end
    games
  end

  def games
    game_stats.length
  end

  def points
    points = 0
    game_stats.each do |game|
      if name == game.away_team.name
        points += game.away_score
      else
        points += game.home_score
      end
    end
    points
  end

  def points_per_game
    if games == 0
      0
    else
      (points.to_f/games)
    end
  end

  def plays
    calculate_stat("plays")
  end

  def plays_per_game
    if games == 0
      0
    else
      (plays.to_f/games)
    end
  end

  def yards
    calculate_stat("yards")
  end

  def yards_per_game
    if games == 0
      0
    else
      (yards.to_f/games)
    end
  end

  def yards_per_play
    if plays == 0
      0
    else
      (yards.to_f/plays)
    end
  end

  def third_down_conversions
    calculate_stat("third_down_conversions")
  end

  def third_down_attempts
    calculate_stat("third_down_attempts")
  end

  def third_down_percentage
    if third_down_attempts == 0
      0
    else
      ((third_down_conversions.to_f)/third_down_attempts) * 100
    end
  end

  def penalties
    calculate_stat("penalties")
  end

  def penalty_yards
    calculate_stat("penalty_yards")
  end

  def penalty_yards_per_game
    if games == 0
      0
    else
      (penalty_yards.to_f/games)
    end
  end

  def fumbles
    calculate_stat("fumbles")
  end

  def fumbles_lost
    calculate_stat("fumbles_lost")
  end

  def interceptions
    calculate_stat("interceptions")
  end

  def turnovers
    fumbles_lost + interceptions
  end

  def turnovers_per_game
    if games == 0
      0
    else
      (turnovers.to_f/games)
    end
  end

  def calculate_stat(statistic)
    total = 0
    game_stats.each do |game|
      if name == game.away_team.name
        total += game.stat.send("away_#{statistic}")
      else
        total += game.stat.send("home_#{statistic}")
      end
    end
    total
  end

  # @teams.each do |team|
  #   games = game_stats(team)
  #   points = 0
  #   plays = 0
  #   yards = 0
  #   third_conv = 0
  #   third_att = 0
  #   penalties = 0
  #   penalty_yards = 0
  #   fumbles = 0
  #   fumbles_lost = 0
  #   interceptions = 0
  #   games.each do |game|
  #     if game.away_team.name == team.name
  #       points += game.away_score
  #       plays += game.stat.away_plays
  #       yards += game.stat.away_yards
  #       third_conv += game.stat.away_third_down_conversions
  #       third_att += game.stat.away_third_down_attempts
  #       penalties += game.stat.away_penalties
  #       penalty_yards += game.stat.away_penalty_yards
  #       fumbles += game.stat.away_fumbles
  #       fumbles_lost += game.stat.away_fumbles_lost
  #       interceptions += game.stat.away_interceptions
  #     else
  #       points += game.home_score
  #       plays += game.stat.home_plays
  #       yards += game.stat.home_yards
  #       third_conv += game.stat.home_third_down_conversions
  #       third_att += game.stat.home_third_down_attempts
  #       penalties += game.stat.home_penalties
  #       penalty_yards += game.stat.home_penalty_yards
  #       fumbles += game.stat.home_fumbles
  #       fumbles_lost += game.stat.home_fumbles_lost
  #       interceptions += game.stat.home_interceptions
  #     end
  #   end
  # end
end

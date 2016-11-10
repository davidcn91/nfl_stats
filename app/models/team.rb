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

  def points(side)
    points = 0
    game_stats.each do |game|
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

  def points_per_game(side)
    if games == 0
      0
    else
      (points(side).to_f/games)
    end
  end

  def plays(side)
    if (side == "offense")
      calculate_stat("plays")
    else
      calculate_stat_allowed("plays")
    end
  end

  def plays_per_game(side)
    if games == 0
      0
    else
      (plays(side).to_f/games)
    end
  end

  def yards(side)
    if (side == "offense")
      calculate_stat("yards")
    else
      calculate_stat_allowed("yards")
    end
  end

  def yards_per_game(side)
    if games == 0
      0
    else
      (yards(side).to_f/games)
    end
  end

  def yards_per_play(side)
    if plays(side) == 0
      0
    else
      (yards(side).to_f/plays(side))
    end
  end

  def third_down_conversions(side)
    if (side == "offense")
      calculate_stat("third_down_conversions")
    else
      calculate_stat_allowed("third_down_conversions")
    end
  end

  def third_down_attempts(side)
    if (side == "offense")
      calculate_stat("third_down_attempts")
    else
      calculate_stat_allowed("third_down_attempts")
    end
  end

  def third_down_percentage(side)
    if third_down_attempts(side) == 0
      0
    else
      ((third_down_conversions(side).to_f)/third_down_attempts(side)) * 100
    end
  end

  def penalties(side)
    if (side == "offense")
      calculate_stat("penalties")
    else
      calculate_stat_allowed("penalties")
    end
  end

  def penalty_yards(side)
    if (side == "offense")
      calculate_stat("penalty_yards")
    else
      calculate_stat_allowed("penalty_yards")
    end
  end

  def penalty_yards_per_game(side)
    if games == 0
      0
    else
      (penalty_yards(side).to_f/games)
    end
  end

  def fumbles(side)
    if (side == "offense")
      calculate_stat("fumbles")
    else
      calculate_stat_allowed("fumbles")
    end
  end

  def fumbles_lost(side)
    if (side == "offense")
      calculate_stat("fumbles_lost")
    else
      calculate_stat_allowed("fumbles_lost")
    end
  end

  def interceptions(side)
    if (side == "offense")
      calculate_stat("interceptions")
    else
      calculate_stat_allowed("interceptions")
    end
  end

  def turnovers(side)
    fumbles_lost(side) + interceptions(side)
  end

  def turnovers_per_game(side)
    if games == 0
      0
    else
      (turnovers(side).to_f/games)
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

  def calculate_stat_allowed(statistic)
    total = 0
    game_stats.each do |game|
      if name == game.away_team.name
        total += game.stat.send("home_#{statistic}")
      else
        total += game.stat.send("away_#{statistic}")
      end
    end
    total
  end

end

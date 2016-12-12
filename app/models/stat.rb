class Stat < ActiveRecord::Base
  validates :away_plays, :away_yards, :away_third_down_conversions, :away_third_down_attempts,
  :away_penalties, :away_penalty_yards, :away_rushes, :away_rushing_yards, :away_passes, :away_completions,
  :away_passing_yards, :away_fumbles, :away_fumbles_lost, :away_interceptions,
  :home_plays, :home_yards, :home_third_down_conversions, :home_third_down_attempts,
  :home_penalties, :home_penalty_yards, :home_rushes, :home_rushing_yards, :home_passes, :home_completions,
  :home_passing_yards, :home_fumbles, :home_fumbles_lost, :home_interceptions,
  presence: true
  validates :away_plays, :away_third_down_conversions, :away_third_down_attempts,
  :away_penalties, :away_penalty_yards, :away_rushes, :away_passes, :away_completions, :away_fumbles,
  :away_fumbles_lost, :away_interceptions, :home_plays, :home_third_down_conversions, :home_third_down_attempts,
  :home_penalties, :home_penalty_yards, :home_rushes, :home_passes, :home_completions, :home_fumbles,
  :home_fumbles_lost, :home_interceptions, numericality: { greater_than_or_equal_to: 0 }
  validate :away_plays_greater_than_rushing_plus_passing, :home_plays_greater_than_rushing_plus_passing,
  :away_third_down_attempts_greater_than_third_down_conversions, :home_third_down_attempts_greater_than_third_down_conversions,
  :away_fumbles_greater_than_fumbles_lost, :home_fumbles_greater_than_fumbles_lost, :away_passes_greater_than_completions,
  :home_passes_greater_than_completions

  belongs_to :game

  CATEGORIES = [["Team","name"],["G","games"],["Points","points"],["Pts /Gm","points_per_game"],
["Plays","plays"],["Plays /Gm","plays_per_game"],["Yards","yards"],["Yds /Gm","yards_per_game"],["Yds /Play","yards_per_play"],
["Rush","rushes"],["RuYds","rushing_yards"],["RuYds /Gm","rushing_yards_per_game"],["Yds /Rush","yards_per_rush"],
["Comp","completions"],["Pass","passes"],["Comp Pct","completion_percentage"],["PaYds","passing_yards"],["PaYds /Gm","passing_yards_per_game"],["Yds /Pass","yards_per_pass"],
["3rd Conv","third_down_conversions"],["3rd Att","third_down_attempts"],["3rd Pct","third_down_percentage"],
["Pen","penalties"],["Pen Yards","penaty_yards"],["Pen Yds/G","penalty_yards_per_game"],["Fum","fumbles"],
["Fum Lost","fumbles_lost"],["INT","interceptions"],["TO","turnovers"],["TO/G","turnovers_per_game"]]

  def away_plays_greater_than_rushing_plus_passing
    if !away_plays.nil? && !away_rushes.nil? && !away_passes.nil? && (away_plays < (away_rushes + away_passes))
      errors.add(:away_plays, "can't be fewer than rushes plus passes")
    end
  end

  def home_plays_greater_than_rushing_plus_passing
    if !home_plays.nil? && !home_rushes.nil? && !home_passes.nil? && (home_plays < (home_rushes + home_passes))
      errors.add(:home_plays, "can't be fewer than rushes plus passes")
    end
  end

  def away_third_down_attempts_greater_than_third_down_conversions
    if !away_third_down_attempts.nil? && !away_third_down_conversions.nil? && (away_third_down_attempts < (away_third_down_conversions))
      errors.add(:away_third_down_attempts, "can't be fewer than third down conversions")
    end
  end

  def home_third_down_attempts_greater_than_third_down_conversions
    if !home_third_down_attempts.nil? && !home_third_down_conversions.nil? && (home_third_down_attempts < (home_third_down_conversions))
      errors.add(:home_third_down_attempts, "can't be fewer than third down conversions")
    end
  end

  def away_fumbles_greater_than_fumbles_lost
    if !away_fumbles.nil? && !away_fumbles_lost.nil? && (away_fumbles < (away_fumbles_lost))
      errors.add(:away_fumbles, "can't be fewer than fumbles lost")
    end
  end

  def home_fumbles_greater_than_fumbles_lost
    if !home_fumbles.nil? && !home_fumbles_lost.nil? && (home_fumbles < (home_fumbles_lost))
      errors.add(:home_fumbles, "can't be fewer than fumbles lost")
    end
  end

  def away_passes_greater_than_completions
    if !away_completions.nil? && !away_passes.nil? && (away_passes < (away_completions))
      errors.add(:away_passes, "can't be fewer than completions")
    end
  end

  def home_passes_greater_than_completions
    if !home_completions.nil? && !home_passes.nil? && (home_passes < (home_completions))
      errors.add(:home_passes, "can't be fewer than completions")
    end
  end
end

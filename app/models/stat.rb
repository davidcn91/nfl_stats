class Stat < ActiveRecord::Base
  validates :away_plays, :away_yards, :away_third_down_conversions, :away_third_down_attempts,
  :away_penalties, :away_penalty_yards, :away_rushes, :away_rushing_yards, :away_passes,
  :away_passing_yards, :away_time_of_possession, :away_fumbles, :away_fumbles_lost, :away_interceptions,
  :home_plays, :home_yards, :home_third_down_conversions, :home_third_down_attempts,
  :home_penalties, :home_penalty_yards, :home_rushes, :home_rushing_yards, :home_passes,
  :home_passing_yards, :home_time_of_possession, :home_fumbles, :home_fumbles_lost, :home_interceptions,
  presence: true
  validates :away_plays, :away_third_down_conversions, :away_third_down_attempts,
  :away_penalties, :away_penalty_yards, :away_rushes, :away_passes, :away_fumbles,
  :away_fumbles_lost, :away_interceptions, :home_plays, :home_third_down_conversions, :home_third_down_attempts,
  :home_penalties, :home_penalty_yards, :home_rushes, :home_passes, :home_fumbles,
  :home_fumbles_lost, :home_interceptions, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :game
end

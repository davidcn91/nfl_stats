class Game < ActiveRecord::Base
  validates :season, :week, :away_team_id, :home_team_id, :away_score, :home_score, :spread, presence: true
  validates :season, numericality: { greater_than: 1920 }
  validates :week, numericality: { greater_than: 0, less_than_or_equal_to: 17 }
  validates :away_score, :home_score, numericality: { greater_than_or_equal_to: 0 }
  validates_numericality_of :spread

  belongs_to :team
end

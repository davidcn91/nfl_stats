class Game < ActiveRecord::Base
  validates :season, :week, :away_team_id, :home_team_id, :away_score, :home_score, :spread, presence: true
  validates :season, numericality: { greater_than: 2000 }
  validates :week, numericality: { greater_than: 0, less_than_or_equal_to: 17 }
  validates :away_score, :home_score, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :away_team, class_name: 'Team', foreign_key: 'away_team_id'
  belongs_to :home_team, class_name: 'Team', foreign_key: 'home_team_id'

  SEASONS = (2000..2016).to_a.reverse
  WEEKS = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17]
end

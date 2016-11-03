class Game < ActiveRecord::Base
  validates :season, :week, :away_team_id, :home_team_id, :away_score, :home_score, :spread, presence: true
  validates :away_score, :home_score, numericality: { greater_than_or_equal_to: 0 }
  validates :season, numericality: { greater_than_or_equal_to: 2001, less_than_or_equal_to: 2016 }
  validates :week, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 17 }
  validate :teams_cannot_be_same

  def teams_cannot_be_same
    if away_team_id == home_team_id
      errors.add(:away_team_id, "can't be the same as home team")
    end
  end

  belongs_to :away_team, class_name: 'Team', foreign_key: 'away_team_id'
  belongs_to :home_team, class_name: 'Team', foreign_key: 'home_team_id'
  belongs_to :user
  has_one :stat

  SEASONS = (2000..2016).to_a.reverse
  WEEKS = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17]
end

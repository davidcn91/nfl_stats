class Game < ActiveRecord::Base
  validates :season, :week, :away_team_id, :home_team_id, :away_score, :home_score, :spread, presence: true
  validates :away_score, :home_score, numericality: { greater_than_or_equal_to: 0 }
  validates :season, numericality: { greater_than_or_equal_to: 2001, less_than_or_equal_to: 2016 }
  validates :week, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 17 }
  validate :teams_cannot_be_same, :overtime_game_margin


  belongs_to :away_team, class_name: 'Team', foreign_key: 'away_team_id'
  belongs_to :home_team, class_name: 'Team', foreign_key: 'home_team_id'
  belongs_to :user
  has_one :stat, dependent: :destroy

  SEASONS = (2001..2016).to_a.reverse
  WEEKS = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17]
  OVERTIME_MARGINS = [0,2,3,6]

  def teams_cannot_be_same
    if away_team_id == home_team_id
      errors.add(:away_team_id, "can't be the same as home team")
    end
  end

  def overtime_game_margin
    if overtime && (!OVERTIME_MARGINS.include?((away_score - home_score).abs))
      errors.add(:overtime, "game margin must be 0, 2, 3, or 6")
    end
  end
end

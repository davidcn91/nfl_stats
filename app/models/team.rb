class Team < ActiveRecord::Base
  validates :location, :name, :abbreviation, presence: true
  validates :name, :abbreviation, uniqueness: true
  validates :abbreviation, length: { minimum: 2, maximum: 3}

  has_many :games, dependent: :destroy
  has_many :users

  DIVISIONS = ["NFC East", "NFC North", "NFC South", "NFC West",
  "AFC East", "AFC North", "AFC South", "AFC West"]
end

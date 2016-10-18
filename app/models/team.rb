class Team < ActiveRecord::Base
  validates :location, :name, :abbreviation, presence: true
  validates :abbreviation, length: { minimum: 2, maximum: 3}

end

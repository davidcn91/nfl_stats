FactoryGirl.define do
  factory :stat do
    away_plays 50
    away_yards 400
    away_rushes 20
    away_rushing_yards 100
    away_passes 30
    away_completions 20
    away_passing_yards 300
    away_third_down_conversions 5
    away_third_down_attempts 12
    away_fumbles 2
    away_fumbles_lost 1
    away_interceptions 1
    away_time_of_possession "30:00"
    away_penalties 5
    away_penalty_yards 40
    home_plays 50
    home_yards 400
    home_rushes 20
    home_rushing_yards 100
    home_passes 30
    home_completions 20
    home_passing_yards 300
    home_third_down_conversions 5
    home_third_down_attempts 12
    home_fumbles 2
    home_fumbles_lost 1
    home_interceptions 1
    home_time_of_possession "30:00"
    home_penalties 5
    home_penalty_yards 40
  end
end

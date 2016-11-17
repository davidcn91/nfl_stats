RSpec.describe Stat do
  it { should have_valid(:away_plays).when(40,55,70) }
  it { should_not have_valid(:away_plays).when(nil, "", -5) }

  it { should have_valid(:away_yards).when(200,300,400) }
  it { should_not have_valid(:away_yards).when(nil, "") }

  it { should have_valid(:away_third_down_conversions).when(1, 5, 20) }
  it { should_not have_valid(:away_third_down_conversions).when(nil, "", -5) }

  it { should have_valid(:away_third_down_attempts).when(1, 5, 20) }
  it { should_not have_valid(:away_third_down_attempts).when(nil, "", -5) }

  it { should have_valid(:away_penalties).when(0, 4, 8, 20) }
  it { should_not have_valid(:away_penalties).when(-3, "", nil) }

  it { should have_valid(:away_penalty_yards).when(0,50,100) }
  it { should_not have_valid(:away_penalty_yards).when(-3, "", nil) }

  it { should have_valid(:away_rushes).when(5,10,20) }
  it { should_not have_valid(:away_rushes).when(nil, "", -5) }

  it { should have_valid(:away_rushing_yards).when(50,100,150) }
  it { should_not have_valid(:away_rushing_yards).when(nil, "") }

  it { should have_valid(:away_passes).when(15,20,30) }
  it { should_not have_valid(:away_passes).when(nil, "", -5) }

  it { should have_valid(:away_completions).when(15,20,30) }
  it { should_not have_valid(:away_completions).when(nil, "", -5) }

  it { should have_valid(:away_passing_yards).when(200,400,450) }
  it { should_not have_valid(:away_passing_yards).when(nil, "") }

  it { should have_valid(:away_time_of_possession).when(100, 500, 1000) }
  it { should_not have_valid(:away_time_of_possession).when(nil, "") }

  it { should have_valid(:away_fumbles).when(0, 2, 5) }
  it { should_not have_valid(:away_fumbles).when(-3, "", nil) }

  it { should have_valid(:away_fumbles_lost).when(0, 3, 5) }
  it { should_not have_valid(:away_fumbles_lost).when(-3, "", nil) }

  it { should have_valid(:away_interceptions).when(3, 4, 5, 0) }
  it { should_not have_valid(:away_interceptions).when(nil, "", -3) }

  it { should have_valid(:home_plays).when(40,55,70) }
  it { should_not have_valid(:home_plays).when(nil, "", -5) }

  it { should have_valid(:home_yards).when(200,300,400) }
  it { should_not have_valid(:home_yards).when(nil, "") }

  it { should have_valid(:home_third_down_conversions).when(1, 5, 20) }
  it { should_not have_valid(:home_third_down_conversions).when(nil, "", -5) }

  it { should have_valid(:home_third_down_attempts).when(1, 5, 20) }
  it { should_not have_valid(:home_third_down_attempts).when(nil, "", -5) }

  it { should have_valid(:home_penalties).when(0, 4, 8, 20) }
  it { should_not have_valid(:home_penalties).when(-3, "", nil) }

  it { should have_valid(:home_penalty_yards).when(0,50,100) }
  it { should_not have_valid(:home_penalty_yards).when(-3, "", nil) }

  it { should have_valid(:home_rushes).when(5,10,20) }
  it { should_not have_valid(:home_rushes).when(nil, "", -5) }

  it { should have_valid(:home_rushing_yards).when(50,100,150) }
  it { should_not have_valid(:home_rushing_yards).when(nil, "") }

  it { should have_valid(:home_passes).when(15,20,30) }
  it { should_not have_valid(:home_passes).when(nil, "", -5) }

  it { should have_valid(:home_completions).when(15,20,30) }
  it { should_not have_valid(:home_completions).when(nil, "", -5) }

  it { should have_valid(:home_passing_yards).when(200,400,450) }
  it { should_not have_valid(:home_passing_yards).when(nil, "") }

  it { should have_valid(:home_time_of_possession).when(100, 500, 1000) }
  it { should_not have_valid(:home_time_of_possession).when(nil, "") }

  it { should have_valid(:home_fumbles).when(0, 2, 5) }
  it { should_not have_valid(:home_fumbles).when(-3, "", nil) }

  it { should have_valid(:home_fumbles_lost).when(0, 3, 5) }
  it { should_not have_valid(:home_fumbles_lost).when(-3, "", nil) }

  it { should have_valid(:home_interceptions).when(3, 4, 5, 0) }
  it { should_not have_valid(:home_interceptions).when(nil, "", -3) }
end

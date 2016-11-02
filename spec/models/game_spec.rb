require 'rails_helper'

RSpec.describe Game do
  it { should have_valid(:season).when(2016, 2001, 2010) }
  it { should_not have_valid(:season).when(nil, '', 1900, 0) }

  it { should have_valid(:week).when(1, 3, 7, 14, 17) }
  it { should_not have_valid(:week).when(nil, '', 0, 18) }

  it { should have_valid(:away_team_id).when(1, 5, 20) }
  it { should_not have_valid(:away_team_id).when(nil, '') }

  it { should have_valid(:home_team_id).when(1, 5, 20) }
  it { should_not have_valid(:home_team_id).when(nil, '') }

  it { should have_valid(:away_score).when(0, 14, 26, 70) }
  it { should_not have_valid(:away_score).when(-3, '', nil) }

  it { should have_valid(:home_score).when(0, 14, 26, 70) }
  it { should_not have_valid(:home_score).when(-3, '', nil) }

  it { should have_valid(:spread).when(-7.5, 8.5, 0, 4, 20.5) }
  it { should_not have_valid(:spread).when(nil, '') }
end

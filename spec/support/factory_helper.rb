module FactoryHelper
  def factories
    before(:each) do
      @team_1 = FactoryGirl.create(:team)
      @team_2 = FactoryGirl.create(:team, abbreviation: "KC")
      @team_3 = FactoryGirl.create(:team, abbreviation: "MIN")
      @user_1 = FactoryGirl.create(:user, team_id: @team_1.id)
      @user_2 = FactoryGirl.create(:user, team_id: @team_1.id, role: "admin")
      @user_3 = FactoryGirl.create(:user, team_id: @team_1.id)
      @game_1 = FactoryGirl.create(:game, user_id: @user_1.id, away_team_id: @team_1.id, home_team_id: @team_2.id)
      @game_2 = FactoryGirl.create(:game, user_id: @user_1.id, away_team_id: @team_2.id, home_team_id: @team_3.id)
      @stat = FactoryGirl.create(:stat, game_id: @game_1.id)
    end
  end
end

RSpec.configure do |config|
  config.include FactoryHelper, type: :feature
end

feature 'user sees stats', %Q{
  As a user
  I want to see cumulative team stats
  So that I can compare teams in different categories
} do

  # * I should be able to click a link from any page in the app that allows me to view all team stats.
  # * I should see a table with cumulative game statistics for all teams.
  # * I should be able to sort this table by any category by clicking on its header.
  # * I should be able to reverse sort any category by clicking on its header a second time.
  # * I should be able to toggle between offensive and defensive stats by clicking a link.
  # * I should be able to view stats from any specific season.
  # * I should not have to be signed in to view the stats table.

  before(:each) do
    @team_1 = FactoryGirl.create(:team)
    @team_2 = FactoryGirl.create(:team, abbreviation: "KC")
    @team_3 = FactoryGirl.create(:team, abbreviation: "MIN")
    @user_1 = FactoryGirl.create(:user, team_id: @team_1.id)
    @game_1 = FactoryGirl.create(:game, user_id: @user_1.id, away_team_id: @team_1.id, home_team_id: @team_2.id)
    @game_2 = FactoryGirl.create(:game, user_id: @user_1.id, away_team_id: @team_2.id, home_team_id: @team_3.id, week: 7)
    @game_3 = FactoryGirl.create(:game, user_id: @user_1.id, away_team_id: @team_2.id, home_team_id: @team_3.id, week: 9)
    @stat_1 = FactoryGirl.create(:stat, game_id: @game_1.id)
    @stat_2 = FactoryGirl.create(:stat, game_id: @game_2.id)
    @stat_3 = FactoryGirl.create(:stat, game_id: @game_3.id)
  end

  scenario 'user views stats table' do
    sign_in(@user_1)
    click_link "Stats"

    expect(page).to have_content(@team_1.name)
    expect(page).to have_content(@team_2.name)
    expect(page).to have_content(@team_3.name)
    expect(page).to have_content("Offense")
    expect(page).to have_link("View Defensive Stats")
    expect(page).to have_content("Points")
    expect(page).to have_content("Pts /Gm")
    expect(page).to have_content("3rd Conv")
    expect(page).to have_content("Pen Yards")
    expect(page).to have_content("Fum")
    expect(page).to have_content("TO/G")
    expect(page).to have_content("8.0")
    expect(page).to have_content("10.0")
    expect(page).to_not have_content("9.0")
  end

  scenario "user views defensive stats" do
    visit root_path
    click_link "Stats"
    click_link("View Defensive Stats")
    expect(page).to have_content("Defense")
    expect(page).to have_link("View Offensive Stats")
    expect(page).to have_content("Points")
    expect(page).to have_content("Pts /Gm")
    expect(page).to have_content("3rd Conv")
    expect(page).to have_content("Pen Yards")
    expect(page).to have_content("Fum")
    expect(page).to have_content("TO/G")
    expect(page).to have_content("5.0")
    expect(page).to have_content("10.0")
  end

  scenario "user sorts by category" do
    visit root_path
    click_link "Stats"
    click_link("3rd Conv")
    click_link("3rd Conv")
    click_link("Fum")
  end

  scenario "user sorts by season" do
    visit root_path
    click_link "Stats"
    select "2015", from: "season_stats_season"
    click_button "Submit"
    expect(page).to have_content("8.0")
    expect(page).to have_content("10.0")
    select "2011", from: "season_stats_season"
    click_button "Submit"
    expect(page).to_not have_content("8.0")
    expect(page).to_not have_content("10.0")
    click_link("View Defensive Stats")
    expect(page).to have_content("2011")
    click_link("3rd Conv")
    click_link("Fum")
    expect(page).to have_content("2011")
  end
end

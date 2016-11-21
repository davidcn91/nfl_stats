feature 'user views standings page', %Q{
  As a user
  I want to view a standings page
  So that I can view all teams' records
} do

  # * I should be able to view the standings page by clicking a link from any page.
  # * I should be able to see the team's name, their record, winning percentage, and division and conference records.
  # * I should be able to see standings for all seasons or for a particular season by selecting a year in a dropdown menu.

  before(:each) do
    @team_1 = FactoryGirl.create(:team)
    @team_2 = FactoryGirl.create(:team, abbreviation: "CAR")
    @team_3 = FactoryGirl.create(:team, abbreviation: "KC", division: "AFC West")
    @user = FactoryGirl.create(:user, team_id: @team_1.id)
    @game_1 = FactoryGirl.create(:game, user_id: @user.id, away_team_id: @team_1.id, home_team_id: @team_2.id)
    @game_2 = FactoryGirl.create(:game, user_id: @user.id, away_team_id: @team_1.id, home_team_id: @team_3.id, season: 2010, week: 6)
    @game_1 = FactoryGirl.create(:game, user_id: @user.id, away_team_id: @team_1.id, home_team_id: @team_2.id, season: 2011, week: 17)


  end

  scenario "user clicks on standings link" do
    visit root_path
    click_link "Standings"

    expect(page).to have_content("2001-2016")
    expect(page).to have_link("#{@team_1.location} #{@team_1.name}")
    expect(page).to have_link("#{@team_2.location} #{@team_2.name}")
    expect(page).to have_link("#{@team_3.location} #{@team_3.name}")
    expect(page).to have_content("W")
    expect(page).to have_content("L")
    expect(page).to have_content("T")
    expect(page).to have_content("Win %")
    expect(page).to have_content("Div")
    expect(page).to have_content("Conf")
    expect(page).to have_content("PF")
    expect(page).to have_content("PA")
    expect(page).to have_content("Diff")

    expect(page).to have_content("0-2-0")
    expect(page).to have_content("2-0-0")
    expect(page).to have_content("0-0-0")
  end

  scenario "user selects standings season from dropdown" do
    visit root_path
    click_link "Standings"
    select "2015", from: "standings_by_season_season"
    click_button "standings_button"

    expect(page).to have_content("2015")
    expect(page).to_not have_content("0-2-0")
    expect(page).to_not have_content("2-0-0")
    expect(page).to have_content("0-1-0")
    expect(page).to have_content("1-0-0")
  end



end

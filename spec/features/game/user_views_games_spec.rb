feature 'user sees games', %Q{
  As a user
  I want to see all games that have been recorded
  So that I can find information about a given game
} do

  # * If I am on any page, I should be able to view a list of games from a season of my choice.
  # * If I choose a specific season, I should see all games played during that season, listed by week.
  # * If I choose all seasons, I should see all games played during all seasons, listed by season and week.
  # * I should be able to click a link next to each game listed that will show me that game's stats.
  # * I should be able to view game lists by clicking on a season's link from a team page or a game stats page.
  # * I should not have to be signed in to view game lists.

  before(:each) do
    @team_1 = FactoryGirl.create(:team)
    @team_2 = FactoryGirl.create(:team, abbreviation: "KC")
    @team_3 = FactoryGirl.create(:team, abbreviation: "MIN")
    @user_1 = FactoryGirl.create(:user, team_id: @team_1.id)
    @user_2 = FactoryGirl.create(:user, team_id: @team_1.id, role: "admin")
    @user_3 = FactoryGirl.create(:user, team_id: @team_1.id)
    @game_1 = FactoryGirl.create(:game, user_id: @user_1.id, away_team_id: @team_1.id, home_team_id: @team_2.id)
    @game_2 = FactoryGirl.create(:game, user_id: @user_1.id, away_team_id: @team_2.id, home_team_id: @team_3.id, season: 2010, week: 6)
    @stat = FactoryGirl.create(:stat, game_id: @game_1.id)
  end

  scenario 'user views games from all seasons' do
    sign_in(@user_1)
    select "2001-2016", from: "games_by_season_season"
    click_button 'games_button'
    expect(page).to have_content("#{@game_1.away_team.abbreviation} #{@game_1.away_score} at #{@game_1.home_team.abbreviation} #{@game_1.home_score}")
    expect(page).to have_content("#{@game_2.away_team.abbreviation} #{@game_2.away_score} at #{@game_2.home_team.abbreviation} #{@game_2.home_score}")
    expect(page).to have_link("Game Details")
  end

  scenario 'user views games from specific season' do
    visit root_path
    select @game_1.season, from: "games_by_season_season"
    click_button 'games_button'
    expect(page).to have_content("#{@game_1.away_team.abbreviation} #{@game_1.away_score} at #{@game_1.home_team.abbreviation} #{@game_1.home_score}")
    expect(page).to_not have_content("#{@game_2.away_team.abbreviation} #{@game_2.away_score} at #{@game_2.home_team.abbreviation} #{@game_2.home_score}")

    select @game_2.season, from: "games_by_season_season"
    click_button 'games_button'
    expect(page).to have_content("#{@game_2.away_team.abbreviation} #{@game_2.away_score} at #{@game_2.home_team.abbreviation} #{@game_2.home_score}")
    expect(page).to_not have_content("#{@game_1.away_team.abbreviation} #{@game_1.away_score} at #{@game_1.home_team.abbreviation} #{@game_1.home_score}")

    select "2005", from: "games_by_season_season"
    click_button 'games_button'
    expect(page).to_not have_content("#{@game_1.away_team.abbreviation} #{@game_1.away_score} at #{@game_1.home_team.abbreviation} #{@game_1.home_score}")
    expect(page).to_not have_content("#{@game_2.away_team.abbreviation} #{@game_2.away_score} at #{@game_2.home_team.abbreviation} #{@game_2.home_score}")
  end

  scenario 'user clicks season link' do
    sign_in(@user_1)
    click_link "#{@team_1.location} #{@team_1.name}"
    click_link "Game Details"
    click_link "#{@game_1.season}"
    expect(page).to have_content("#{@game_1.away_team.abbreviation} #{@game_1.away_score} at #{@game_1.home_team.abbreviation} #{@game_1.home_score}")

    visit team_path(@team_3.id)
    click_link "#{@game_2.season}"
    expect(page).to have_content("#{@game_2.away_team.abbreviation} #{@game_2.away_score} at #{@game_2.home_team.abbreviation} #{@game_2.home_score}")
  end
end

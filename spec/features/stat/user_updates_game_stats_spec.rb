feature 'user updates game stats', %Q{
  As an authenticated user
  I want to update an game's statistics
  So that I can correct errors or provide new information
} do

  # * If I am the creator of a game or a site admin, I should be able to update a Game's stats.
  # * If I specify valid Stat information, the game stats should be updated.
  # * If I do not specify valid Stat information, the stats should not be updated
  #   and I should be provided an error message.
  # * If I am not the creator of the team or an admin, I should not be able to update the game stats.

  before(:each) do
    @team_1 = FactoryGirl.create(:team)
    @team_2 = FactoryGirl.create(:team, abbreviation: "KC")
    @team_3 = FactoryGirl.create(:team, abbreviation: "MIN")
    @user_1 = FactoryGirl.create(:user, team_id: @team_1.id)
    @user_2 = FactoryGirl.create(:user, team_id: @team_1.id, role: "admin")
    @user_3 = FactoryGirl.create(:user, team_id: @team_1.id)
    @game = FactoryGirl.create(:game, user_id: @user_1.id, away_team_id: @team_1.id, home_team_id: @team_2.id)
    @stat = FactoryGirl.create(:stat, game_id: @game.id)
  end

  scenario "signed in user is the creator of the game and provides valid information" do
    sign_in(@user_1)
    click_link "#{@team_1.location} #{@team_1.name}"
    click_link "Show Stats"
    click_link "Edit Stats"
    fill_in "stat_away_plays", with: "100"
    fill_in "stat_away_yards", with: "700"
    fill_in "stat_away_third_down_conversions", with: "4"
    fill_in "stat_away_third_down_attempts", with: "11"
    fill_in "stat_away_penalties", with: "2"
    fill_in "stat_away_penalty_yards", with: "10"
    fill_in "stat_away_rushes", with: "10"
    fill_in "stat_away_rushing_yards", with: "90"
    fill_in "stat_away_passes", with: "40"
    fill_in "stat_away_completions", with: "25"
    fill_in "stat_away_passing_yards", with: "400"
    fill_in "stat_away_time_of_possession", with: "28:50"
    fill_in "stat_away_fumbles", with: "3"
    fill_in "stat_away_fumbles_lost", with: "2"
    fill_in "stat_away_interceptions", with: "3"
    click_button "Submit Game Stats"

    expect(page).to have_content("100")
    expect(page).to have_content("700")
    expect(page).to have_content("4 / 11")
    expect(page).to have_content("2 (10)")
    expect(page).to have_content("28:50")
  end

  scenario 'signed in user is an admin' do
    sign_in(@user_2)
    click_link "#{@team_1.location} #{@team_1.name}"
    click_link "Show Stats"
    click_link "Edit Stats"
    fill_in "stat_away_plays", with: "100"
    fill_in "stat_away_yards", with: "700"
    fill_in "stat_away_third_down_conversions", with: "4"
    fill_in "stat_away_third_down_attempts", with: "11"
    fill_in "stat_away_penalties", with: "2"
    fill_in "stat_away_penalty_yards", with: "10"
    fill_in "stat_away_rushes", with: "10"
    fill_in "stat_away_rushing_yards", with: "90"
    fill_in "stat_away_passes", with: "40"
    fill_in "stat_away_completions", with: "25"
    fill_in "stat_away_passing_yards", with: "400"
    fill_in "stat_away_time_of_possession", with: "28:50"
    fill_in "stat_away_fumbles", with: "3"
    fill_in "stat_away_fumbles_lost", with: "2"
    fill_in "stat_away_interceptions", with: "3"
    click_button "Submit Game Stats"

    expect(page).to have_content("100")
    expect(page).to have_content("700")
    expect(page).to have_content("4 / 11")
    expect(page).to have_content("2 (10)")
    expect(page).to have_content("28:50")
  end

  scenario 'authenticated user supplies invalid information' do
    sign_in(@user_1)
    click_link "#{@team_1.location} #{@team_1.name}"
    click_link "Show Stats"
    click_link "Edit Stats"

    fill_in "stat_away_plays", with: ""
    fill_in "stat_away_yards", with: ""
    fill_in "stat_away_third_down_conversions", with: ""
    fill_in "stat_away_third_down_attempts", with: ""
    fill_in "stat_away_penalties", with: ""
    click_button "Submit Game Stats"
    expect(page).to_not have_content("Game stats added successfully!")

    fill_in "stat_away_plays", with: "30"
    fill_in "stat_away_yards", with: "500"
    fill_in "stat_away_third_down_conversions", with: "14"
    fill_in "stat_away_third_down_attempts", with: "13"
    fill_in "stat_away_penalties", with: "7"
    fill_in "stat_away_penalty_yards", with: "50"
    fill_in "stat_away_rushes", with: "20"
    fill_in "stat_away_rushing_yards", with: "80"
    fill_in "stat_away_passes", with: "30"
    fill_in "stat_away_completions", with: "40"
    fill_in "stat_away_passing_yards", with: "300"
    fill_in "stat_away_time_of_possession", with: "32:50"
    fill_in "stat_away_fumbles", with: "1"
    fill_in "stat_away_fumbles_lost", with: "3"
    fill_in "stat_away_interceptions", with: "2"

    fill_in "stat_home_plays", with: "50"
    fill_in "stat_home_yards", with: "500"
    fill_in "stat_home_third_down_conversions", with: "6"
    fill_in "stat_home_third_down_attempts", with: "13"
    fill_in "stat_home_penalties", with: "7"
    fill_in "stat_home_penalty_yards", with: "50"
    fill_in "stat_home_rushes", with: "20"
    fill_in "stat_home_rushing_yards", with: "80"
    fill_in "stat_home_passes", with: "30"
    fill_in "stat_home_completions", with: "20"
    fill_in "stat_home_passing_yards", with: "300"
    fill_in "stat_home_time_of_possession", with: "32:50"
    fill_in "stat_home_fumbles", with: "1"
    fill_in "stat_home_fumbles_lost", with: "1"
    fill_in "stat_home_interceptions", with: "2"

    click_button "Submit Game Stats"
    expect(page).to_not have_content("Game stats added successfully!")
    expect(page).to have_content("Away plays can't be fewer than rushes plus passes")
    expect(page).to have_content("Away third down attempts can't be fewer than third down conversions")
    expect(page).to have_content("Away fumbles can't be fewer than fumbles lost")
    expect(page).to have_content("Away passes can't be fewer than completions")
  end

  scenario 'signed in user is not creator of the team' do
    sign_in(@user_3)
    click_link "#{@team_1.location} #{@team_1.name}"
    expect(page).to have_content("Week #{@game.week}: #{@game.away_team.name} #{@game.away_score} @ #{@game.home_team.name} #{@game.home_score}")
    click_link "Show Stats"
    expect(page).to_not have_link("Edit Stats")
    expect{visit edit_game_stat_path(@game.id, @game.stat.id)}.to raise_error(ActionController::RoutingError)
  end

  scenario 'user is not signed in' do
    visit root_path
    click_link "#{@team_1.location} #{@team_1.name}"
    expect(page).to have_content("Week #{@game.week}: #{@game.away_team.name} #{@game.away_score} @ #{@game.home_team.name} #{@game.home_score}")
    click_link "Show Stats"
    expect(page).to_not have_link("Edit Stats")
    expect{visit edit_game_stat_path(@game.id, @game.stat.id)}.to raise_error(ActionController::RoutingError)
  end
end

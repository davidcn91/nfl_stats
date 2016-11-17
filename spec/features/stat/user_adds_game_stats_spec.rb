feature 'user adds game stats', %Q{
  As an authenticated user
  I want to add statistics for a game
  So that others can view it on the game page
} do

  # * If I am the creator of a game or a site admin, I should be able to add stats for that game.
  # * If I specify valid information, the stats should be added to the game page.
  # * If I am not the creator of the game or an admin, I should not be able to add stats.
  # * If I am not logged in, I should not be able to add game stats
  #   and should receive an message indicating that I need to sign in.
  # * If I do not specify valid review information, the review should not be added
  #   and I should be provided an error message specifying the issue.

  before(:each) do
    @team_1 = FactoryGirl.create(:team)
    @team_2 = FactoryGirl.create(:team, abbreviation: "KC")
    @user_1 = FactoryGirl.create(:user, team_id: @team_1.id)
    @user_2 = FactoryGirl.create(:user, team_id: @team_1.id, role: "admin")
    @user_3 = FactoryGirl.create(:user, team_id: @team_1.id)
    @game = FactoryGirl.create(:game, user_id: @user_1.id, away_team_id: @team_1.id, home_team_id: @team_2.id)
  end

  scenario "signed in user is the creator of the game and provides valid information" do
    sign_in(@user_1)
    click_link "#{@team_1.location} #{@team_1.name}"
    expect(page).to have_content("Week #{@game.week}: #{@game.away_team.name} #{@game.away_score} at #{@game.home_team.name} #{@game.home_score}")
    click_link "Add Stats"

    fill_in "stat_away_plays", with: "50"
    fill_in "stat_away_yards", with: "500"
    fill_in "stat_away_third_down_conversions", with: "6"
    fill_in "stat_away_third_down_attempts", with: "13"
    fill_in "stat_away_penalties", with: "7"
    fill_in "stat_away_penalty_yards", with: "50"
    fill_in "stat_away_rushes", with: "20"
    fill_in "stat_away_rushing_yards", with: "80"
    fill_in "stat_away_passes", with: "30"
    fill_in "stat_away_completions", with: "20"
    fill_in "stat_away_passing_yards", with: "300"
    fill_in "stat_away_fumbles", with: "1"
    fill_in "stat_away_fumbles_lost", with: "1"
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
    fill_in "stat_home_fumbles", with: "1"
    fill_in "stat_home_fumbles_lost", with: "1"
    fill_in "stat_home_interceptions", with: "2"

    click_button "Submit Game Stats"
    expect(page).to have_content("Game stats added successfully!")
    expect(page).to have_content("#{@game.season} Week #{@game.week}: #{@game.away_team.location} #{@game.away_team.name} #{@game.away_score} at #{@game.home_team.location} #{@game.home_team.name} #{@game.home_score}")
  end

  scenario 'signed in user is an admin' do
    sign_in(@user_2)
    click_link "#{@team_1.location} #{@team_1.name}"
    expect(page).to have_content("Week #{@game.week}: #{@game.away_team.name} #{@game.away_score} at #{@game.home_team.name} #{@game.home_score}")
    click_link "Add Stats"

    fill_in "stat_away_plays", with: "50"
    fill_in "stat_away_yards", with: "500"
    fill_in "stat_away_third_down_conversions", with: "6"
    fill_in "stat_away_third_down_attempts", with: "13"
    fill_in "stat_away_penalties", with: "7"
    fill_in "stat_away_penalty_yards", with: "50"
    fill_in "stat_away_rushes", with: "20"
    fill_in "stat_away_rushing_yards", with: "80"
    fill_in "stat_away_passes", with: "30"
    fill_in "stat_away_completions", with: "20"
    fill_in "stat_away_passing_yards", with: "300"
    fill_in "stat_away_fumbles", with: "1"
    fill_in "stat_away_fumbles_lost", with: "1"
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
    fill_in "stat_home_fumbles", with: "1"
    fill_in "stat_home_fumbles_lost", with: "1"
    fill_in "stat_home_interceptions", with: "2"

    click_button "Submit Game Stats"
    expect(page).to have_content("Game stats added successfully!")
    expect(page).to have_content("#{@game.season} Week #{@game.week}: #{@game.away_team.location} #{@game.away_team.name} #{@game.away_score} at #{@game.home_team.location} #{@game.home_team.name} #{@game.home_score}")
  end

  scenario 'authenticated user supplies invalid information' do
    sign_in(@user_1)
    click_link "#{@team_1.location} #{@team_1.name}"
    click_link "Add Stats"

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
    expect(page).to have_content("Week #{@game.week}: #{@game.away_team.name} #{@game.away_score} at #{@game.home_team.name} #{@game.home_score}")
    expect(page).to_not have_link("Add Stats")
    expect{visit new_game_stat_path(@game.id)}.to raise_error(ActionController::RoutingError)
  end

  scenario 'user is not signed in' do
    visit root_path
    click_link "#{@team_1.location} #{@team_1.name}"
    expect(page).to have_content("Week #{@game.week}: #{@game.away_team.name} #{@game.away_score} at #{@game.home_team.name} #{@game.home_score}")
    expect(page).to_not have_link("Add Stats")
    expect{visit new_game_stat_path(@game.id)}.to raise_error(ActionController::RoutingError)
  end

end

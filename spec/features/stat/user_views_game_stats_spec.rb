feature 'user sees game stats', %Q{
  As a user
  I want to see a game's information
  So that I can find statistics and game details
} do

  # * If I am on a team's page, I should be able to view details for any game they've played.
  # * If stats have been added for a given game, I should see them on the game page.
  # * If stats have not been added, I should see a message indicating that there are no stats for this game.
  # * If I am authorized to add stats for the given game, there should be a link to add stats
  #   from the game page.

  before(:each) do
    @team_1 = FactoryGirl.create(:team)
    @team_2 = FactoryGirl.create(:team, abbreviation: "KC")
    @team_3 = FactoryGirl.create(:team, abbreviation: "MIN")
    @user_1 = FactoryGirl.create(:user, team_id: @team_1.id)
    @user_2 = FactoryGirl.create(:user, team_id: @team_1.id, role: "admin")
    @user_3 = FactoryGirl.create(:user, team_id: @team_1.id)
    @game_1 = FactoryGirl.create(:game, user_id: @user_1.id, away_team_id: @team_1.id, home_team_id: @team_2.id)
    @game_2 = FactoryGirl.create(:game, user_id: @user_1.id, away_team_id: @team_2.id, home_team_id: @team_3.id, week: 6)
    @stat = FactoryGirl.create(:stat, game_id: @game_1.id)
  end

  scenario 'user views game that has stats' do
    sign_in(@user_1)
    click_link "#{@team_1.location} #{@team_1.name}"
    click_link "Game Stats"

    expect(page).to have_content("#{@game_1.season} Week #{@game_1.week}: #{@game_1.away_team.location} #{@game_1.away_team.name} #{@game_1.away_score} at #{@game_1.home_team.location} #{@game_1.home_team.name} #{@game_1.home_score}")
    expect(page).to have_content(@game_1.stat.away_plays)
    expect(page).to have_content("50")
    expect(page).to have_content(@game_1.stat.away_yards)
    expect(page).to have_content("400")
    expect(page).to have_content("#{(@game_1.stat.away_yards.to_f/@game_1.stat.away_plays)}")
    expect(page).to have_content("8")
    expect(page).to have_content("#{@game_1.stat.away_rushes} - #{@game_1.stat.away_rushing_yards}")
    expect(page).to have_content("20 - 100")
    expect(page).to have_content("#{(@game_1.stat.away_rushing_yards.to_f/@game_1.stat.away_rushes)}")
    expect(page).to have_content("5")
    expect(page).to have_content("#{@game_1.stat.away_completions} / #{@game_1.stat.away_passes}")
    expect(page).to have_content("20 / 30")
    expect(page).to have_content(@game_1.stat.away_passing_yards)
    expect(page).to have_content("300")
    expect(page).to have_content("#{(@game_1.stat.away_passing_yards.to_f/@game_1.stat.away_passes)}")
    expect(page).to have_content("10")
    expect(page).to have_content("#{@game_1.stat.away_third_down_conversions} / #{@game_1.stat.away_third_down_attempts}")
    expect(page).to have_content("5 / 12")
    expect(page).to have_content("#{@game_1.stat.away_fumbles} (#{@game_1.stat.away_fumbles_lost})")
    expect(page).to have_content("2 (1)")
    expect(page).to have_content(@game_1.stat.away_interceptions)
    expect(page).to have_content("1")
    expect(page).to have_content(@game_1.stat.away_fumbles_lost + @game_1.stat.away_interceptions)
    expect(page).to have_content("2")
    expect(page).to have_content("#{@game_1.stat.away_penalties} (#{@game_1.stat.away_penalty_yards})")
    expect(page).to have_content("5 (40)")
  end

  scenario 'authorized user view game that does not have stats' do
    sign_in(@user_1)
    click_link "#{@team_3.location} #{@team_3.name}"
    visit game_path(@game_2.id)
    expect(page).to have_content("#{@game_2.season} Week #{@game_2.week}: #{@game_2.away_team.location} #{@game_2.away_team.name} #{@game_2.away_score} at #{@game_2.home_team.location} #{@game_2.home_team.name} #{@game_2.home_score}")
    expect(page).to have_content("No Stats Provided For This Game")
    expect(page).to have_link("Add Stats")
    click_link "Add Stats"
    expect(page).to have_content("Add Stats")
  end

  scenario 'unauthorized user view game that does not have stats' do
    visit game_path(@game_2.id)
    expect(page).to have_content("No Stats Provided For This Game")
    expect(page).to_not have_link("Add Stats")

    sign_in(@user_3)
    visit game_path(@game_2.id)
    expect(page).to have_content("No Stats Provided For This Game")
    expect(page).to_not have_link("Add Stats")
  end
end

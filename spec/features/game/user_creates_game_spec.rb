feature 'user creates game', %Q{
  As an authenticated user
  I want to add a game
  So that others can view it
} do

  # * If I am logged in, I should be able to add a Game.
  # * If I specify valid Game information, the Game should be added.
  # * If I am not logged in, I should not be able to add a Game.
  # * If I do not specify valid Game information, the Game should not be added
  #   and I should be provided an error message specifying the issue.

  before(:each) do
    @team_1 = FactoryGirl.create(:team)
    @team_2 = FactoryGirl.create(:team, abbreviation: "KC")
    @user = FactoryGirl.create(:user, team_id: @team_1.id)
  end

  scenario 'authenticated user supplies valid information' do
    sign_in(@user)
    click_link 'Add Game'
    select 2015, from: 'Season'
    select 4, from: 'Week'
    select @team_1.name, from: 'game_away_team_id'
    select @team_2.name, from: 'game_home_team_id'
    fill_in 'Away Score', with: '27'
    fill_in 'Home Score', with: '14'
    fill_in 'Spread', with: '4'
    click_button 'Submit Game'

    expect(page).to have_content("Game added successfully!")
    expect(page).to have_content("Add Stats")
  end

  scenario 'user is not signed in' do
    visit root_path
    expect(page).to_not have_content("Add Game")
  end

  scenario 'authenticated user supplies invalid information' do
    sign_in(@user)
    click_link 'Add Game'
    click_button 'Submit Game'

    expect(page).to_not have_content("Game added successfully!")
    expect(page).to have_content("Season can't be blank")
    expect(page).to have_content("Week can't be blank")
    expect(page).to have_content("Away team can't be blank")
    expect(page).to have_content("Home team can't be blank")
    expect(page).to have_content("Away score can't be blank")
    expect(page).to have_content("Home score can't be blank")
    expect(page).to have_content("Spread can't be blank")

    select 2015, from: 'Season'
    select 4, from: 'Week'
    select @team_1.name, from: 'game_away_team_id'
    select @team_1.name, from: 'game_home_team_id'
    fill_in 'Away Score', with: '27'
    fill_in 'Home Score', with: '14'
    fill_in 'Spread', with: '4'
    check 'Overtime'
    click_button 'Submit Game'

    expect(page).to have_content("Away team can't be the same as home team")
    expect(page).to have_content("Overtime game margin must be 0, 2, 3, or 6")

    select @team_1.name, from: 'game_away_team_id'
    select @team_2.name, from: 'game_home_team_id'
    fill_in 'Away Score', with: 'x'
    fill_in 'Home Score', with: 'y'
    click_button 'Submit Game'

    expect(page).to have_content("Away score is not a number")
    expect(page).to have_content("Home score is not a number")

    select @team_1.name, from: 'game_away_team_id'
    select @team_2.name, from: 'game_home_team_id'
    fill_in 'Away Score', with: '-5'
    fill_in 'Home Score', with: '-10'
    click_button 'Submit Game'
    expect(page).to have_content("Away score must be greater than or equal to 0")
    expect(page).to have_content("Home score must be greater than or equal to 0")
  end

  scenario 'authenticated user enters team who already has a game for the entered week' do
    sign_in(@user)
    click_link 'Add Game'
    select 2015, from: 'Season'
    select 4, from: 'Week'
    select @team_1.name, from: 'game_away_team_id'
    select @team_2.name, from: 'game_home_team_id'
    fill_in 'Away Score', with: '27'
    fill_in 'Home Score', with: '14'
    fill_in 'Spread', with: '4'
    click_button 'Submit Game'

    click_link 'Add Game'
    select 2015, from: 'Season'
    select 4, from: 'Week'
    select @team_1.name, from: 'game_away_team_id'
    select @team_2.name, from: 'game_home_team_id'
    fill_in 'Away Score', with: '30'
    fill_in 'Home Score', with: '16'
    fill_in 'Spread', with: '4'
    click_button 'Submit Game'

    expect(page).to_not have_content("Game added successfully!")
    expect(page).to have_content("Away team already has game entered this week")
    expect(page).to have_content("Home team already has game entered this week")
  end
end

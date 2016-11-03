require 'rails_helper'
require 'support/sign_in_helper'

feature 'user updates game', %Q{
  As an authenticated user
  I want to update an game's information
  So that I can correct errors or provide new information
} do

  # * If I am the creator of a game or a site admin, I should be able to update the Game.
  # * If I specify valid Game information, the Game should be updated.
  # * If I do not specify valid Game information, the Game should not be updated
  #   and I should be provided an error message.
  # * If I am not the creator of the team or an admin, I should not be able to update the Game.

  before(:each) do
    @team_1 = FactoryGirl.create(:team)
    @team_2 = FactoryGirl.create(:team, abbreviation: "KC")
    @team_3 = FactoryGirl.create(:team, abbreviation: "MIN")
    @user_1 = FactoryGirl.create(:user, team_id: @team_1.id)
    @user_2 = FactoryGirl.create(:user, team_id: @team_1.id, role: "admin")
    @user_3 = FactoryGirl.create(:user, team_id: @team_1.id)
    @game = FactoryGirl.create(:game, user_id: @user_1.id, away_team_id: @team_1.id, home_team_id: @team_2.id)
  end

  scenario 'signed in user is the creator of the game and provides valid information' do
    sign_in(@user_1)
    click_link "#{@team_1.location} #{@team_1.name}"
    expect(page).to have_content("Week #{@game.week}: #{@game.away_team.name} #{@game.away_score} @ #{@game.home_team.name} #{@game.home_score}")

    click_link "Edit Game"
    select 2010, from: 'Season'
    select 4, from: 'Week'
    select @team_3.name, from: 'game_away_team_id'
    select @team_1.name, from: 'game_home_team_id'
    fill_in 'Away Score', with: '27'
    fill_in 'Home Score', with: '14'
    fill_in 'Spread', with: '4'
    click_button 'Submit Game'

    expect(page).to have_content("Game updated successfully!")
    click_link "#{@team_1.location} #{@team_1.name}"
    expect(page).to have_content("Week 4: #{@team_3.name} 27 @ #{@team_1.name} 14")
  end

  scenario 'signed in user is an admin' do
    sign_in(@user_2)
    click_link "#{@team_1.location} #{@team_1.name}"
    expect(page).to have_content("Week #{@game.week}: #{@game.away_team.name} #{@game.away_score} @ #{@game.home_team.name} #{@game.home_score}")

    click_link "Edit Game"
    select 2010, from: 'Season'
    select 4, from: 'Week'
    select @team_3.name, from: 'game_away_team_id'
    select @team_1.name, from: 'game_home_team_id'
    fill_in 'Away Score', with: '27'
    fill_in 'Home Score', with: '14'
    fill_in 'Spread', with: '4'
    click_button 'Submit Game'

    expect(page).to have_content("Game updated successfully!")
    click_link "#{@team_3.location} #{@team_3.name}"
    expect(page).to have_content("Week 4: #{@team_3.name} 27 @ #{@team_1.name} 14")
  end

  scenario 'authenticated user supplies invalid information' do
    sign_in(@user_1)
    click_link 'Add Game'
    fill_in 'Away Score', with: ''
    fill_in 'Home Score', with: ''
    fill_in 'Spread', with: ''
    click_button 'Submit Game'

    expect(page).to_not have_content("Game updated successfully!")
    expect(page).to have_content("Away score can't be blank")
    expect(page).to have_content("Home score can't be blank")
    expect(page).to have_content("Spread can't be blank")

    select @team_1.name, from: 'game_away_team_id'
    select @team_1.name, from: 'game_home_team_id'
    fill_in 'Away Score', with: '27'
    fill_in 'Home Score', with: '14'
    fill_in 'Spread', with: '4'
    click_button 'Submit Game'

    expect(page).to_not have_content("Game updated successfully!")
    expect(page).to have_content("Away team can't be the same as home team")

    select @team_1.name, from: 'game_away_team_id'
    select @team_2.name, from: 'game_home_team_id'
    fill_in 'Away Score', with: 'x'
    fill_in 'Home Score', with: 'y'
    click_button 'Submit Game'

    expect(page).to_not have_content("Game updated successfully!")
    expect(page).to have_content("Away score is not a number")
    expect(page).to have_content("Home score is not a number")

    select @team_1.name, from: 'game_away_team_id'
    select @team_2.name, from: 'game_home_team_id'
    fill_in 'Away Score', with: '-5'
    fill_in 'Home Score', with: '-10'
    click_button 'Submit Game'

    expect(page).to_not have_content("Game updated successfully!")
    expect(page).to have_content("Away score must be greater than or equal to 0")
    expect(page).to have_content("Home score must be greater than or equal to 0")
  end

  scenario 'signed in user is not creator of the team' do
    sign_in(@user_3)
    click_link "#{@team_1.location} #{@team_1.name}"
    expect(page).to have_content("Week #{@game.week}: #{@game.away_team.name} #{@game.away_score} @ #{@game.home_team.name} #{@game.home_score}")
    expect(page).to_not have_link("Edit Game")
    expect{visit edit_game_path(@game.id)}.to raise_error(ActionController::RoutingError)
  end

  scenario 'user is not signed in' do
    visit root_path
    click_link "#{@team_1.location} #{@team_1.name}"
    expect(page).to have_content("Week #{@game.week}: #{@game.away_team.name} #{@game.away_score} @ #{@game.home_team.name} #{@game.home_score}")
    expect(page).to_not have_button("Edit Game")
    expect{visit edit_game_path(@game.id)}.to raise_error(ActionController::RoutingError)
  end
end

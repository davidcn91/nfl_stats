require 'rails_helper'

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

  scenario 'authenticated user supplies valid information' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign In'
    click_link "#{@team.location} #{@team.name} (#{@team.league})"

    click_link 'Add Review'
    fill_in 'Body', with: @body
    select 8, from: 'Rate Team (1-10)'
    click_button 'Submit Review'

    expect(page).to have_content("Review added successfully!")
    expect(page).to have_content(@body)
    expect(page).to have_content('8')
    expect(page).to have_content("Add Review")
  end

  scenario 'authenticated user supplies review body but does not provide rating' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign In'
    click_link "#{@team.location} #{@team.name} (#{@team.league})"

    click_link 'Add Review'
    fill_in 'Body', with: @body
    click_button 'Submit Review'

    expect(page).to have_content("Review added successfully!")
    expect(page).to have_content(@body)
    expect(page).to_not have_content('Team Rating')
    expect(page).to have_content("Add Review")
  end

  scenario 'user is not signed in' do
    visit root_path
    click_link "#{@team.location} #{@team.name} (#{@team.league})"
    expect(page).to_not have_content("Add Review")

    visit new_team_review_path(@team.id)
    fill_in 'Body', with: @body
    select 8, from: 'Rate Team (1-10)'
    click_button 'Submit Review'
    expect(page).to have_content("You must be signed in to add a review.")
    expect(page).to_not have_content("Add Review")
  end

  scenario 'authenticated user supplies invalid information' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Sign In'
    click_link "#{@team.location} #{@team.name} (#{@team.league})"

    click_link 'Add Review'
    fill_in 'Body', with: 'Too short of a review'
    click_button 'Submit Review'

    expect(page).to have_content("Review length must be 30 characters or greater.")
    expect(page).to_not have_content(@body)
    expect(page).to have_button("Submit Review")
  end

end

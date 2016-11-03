require 'rails_helper'

feature 'user signs in', %Q{
  As an unauthenticated user
  I want to sign in
  So that I can post new games
} do

  # * If I specify a valid, previously registered email and password,
  #   I am authenticated and I gain access to the system
  # * If I specify an invalid email and password, I remain unauthenticated
  # * If I am already signed in, I can't sign in again

  before(:each) do
    @team = FactoryGirl.create(:team)
    @user = FactoryGirl.create(:user, team_id: @team.id)
  end

  scenario "an existing user supplies a valid email and password" do
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Sign In"
    expect(page).to have_content("Welcome Back!")
    expect(page).to have_content("Sign Out")
  end

  scenario "a nonexistent email and password is supplied" do
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_button "Sign In"
    expect(page).to have_content("Invalid Email or password.")
    expect(page).to_not have_content("Welcome Back!")
    expect(page).to_not have_content("Sign Out")
  end

  scenario "an existing email with the wrong password is denied access" do
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: @user.email
    fill_in "Password", with: "wrong password"
    click_button "Sign In"
    expect(page).to have_content("Invalid Email or password.")
    expect(page).to_not have_content("Welcome Back!")
    expect(page).to_not have_content("Sign Out")
  end

  scenario "an already authenticated user cannot re-sign in" do
    visit root_path
    click_link "Sign In"
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Sign In"

    expect(page).to have_content("Sign Out")
    expect(page).to_not have_content("Sign In")

    visit new_user_session_path

    expect(page).to have_content("You are already signed in.")
  end
end

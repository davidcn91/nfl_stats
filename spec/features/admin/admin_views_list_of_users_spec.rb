require 'rails_helper'

feature 'admin views list of users', %Q{
  As an admin
  I want to view a list of users
  So that I can edit or delete them
} do

  # * If I am an admin, I should be able to navigate to a list of users
  #   from the home page.
  # * If I am not an admin, I should not be able to see a list of users.

  scenario 'admin view list of users' do
    team = FactoryGirl.create(:team)
    user_1 = FactoryGirl.create(:user, role: 'admin', team_id: team.id)
    user_2 = FactoryGirl.create(:user, team_id: team.id)
    user_3 = FactoryGirl.create(:user, team_id: team.id)
    user_4 = FactoryGirl.create(:user, team_id: team.id)
    user_5 = FactoryGirl.create(:user, team_id: team.id)
    sign_in(user_1)
    click_link "Users"

    expect(page).to have_content(user_2.email)
    expect(page).to have_content(user_2.first_name)
    expect(page).to have_content(user_2.last_name)
    expect(page).to have_content(user_3.email)
    expect(page).to have_content(user_3.first_name)
    expect(page).to have_content(user_3.last_name)
    expect(page).to have_content(user_4.email)
    expect(page).to have_content(user_4.first_name)
    expect(page).to have_content(user_4.last_name)
    expect(page).to have_content(user_5.email)
    expect(page).to have_content(user_5.first_name)
    expect(page).to have_content(user_5.last_name)
  end

  scenario 'non-admin tries to view list of users' do
    team = FactoryGirl.create(:team)
    user_1 = FactoryGirl.create(:user, team_id: team.id)
    user_2 = FactoryGirl.create(:user, team_id: team.id)
    sign_in(user_1)

    expect(page).to_not have_link('Users')

    expect{visit users_path}.to raise_error(ActionController::RoutingError)
  end
end

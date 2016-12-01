require 'rails_helper'

feature 'admin deletes user', %Q{
  As an admin
  I want to delete a user
  So that I can protect my app
} do

  # * If I am an admin, I should be able to delete a user from the
  #   users index page.
  # * If I am not an admin, I should not be able to delete a user.

  scenario 'admin deletes a user' do
    team = FactoryGirl.create(:team)
    user_1 = FactoryGirl.create(:user, team_id: team.id, role: 'admin')
    user_2 = FactoryGirl.create(:user, team_id: team.id)
    sign_in(user_1)
    click_link "Users"

    expect(page).to have_content(user_2.first_name)
    expect(page).to have_content(user_2.last_name)
    expect(page).to have_content(user_2.email)
    click_button "Delete User"
    expect(page).to_not have_content(user_2.first_name)
    expect(page).to_not have_content(user_2.last_name)
    expect(page).to_not have_content(user_2.email)
  end

end

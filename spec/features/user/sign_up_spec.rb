feature 'user signs up' , %Q{
  As a prospective user
  I want to create an account
  So that I can post new games
} do

  # ACCEPTANCE CRITERIA
  # * I must specify a valid email address
  # * I must specify a password, and confirm that password
  # * I must select my favorite team
  # * If I do not perform the above, I get an error message
  # * If I specify valid information, I register my account and am authenticated

  before(:each) do
    @team = FactoryGirl.create(:team)
  end

  scenario "specifying valid and required information" do
    visit root_path
    click_link "Sign Up"
    fill_in "First Name", with: "Matt"
    fill_in "Last Name", with: "Ryan"
    fill_in "Email", with: "user@example.com"
    fill_in "user_password", with: "password"
    fill_in "Password Confirmation", with: "password"
    select @team.name, from: "user_team_id"
    click_button "Sign Up"

    expect(page).to have_content("You're In!")
    expect(page).to have_content("Sign Out")
  end

  scenario "required information is not supplied" do
    visit root_path
    click_link "Sign Up"
    click_button "Sign Up"

    expect(page).to have_content("can't be blank")
    expect(page).to have_content("Must choose favorite team")
    expect(page).to_not have_content("Sign Out")
  end

  scenario "password confirmation does not match confirmation" do
    visit root_path
    click_link "Sign Up"
    fill_in "First Name", with: "Matt"
    fill_in "Last Name", with: "Ryan"
    fill_in "Email", with: "user@example.com"
    fill_in "user_password", with: "password"
    fill_in "Password Confirmation", with: "somethingdifferent"
    click_button "Sign Up"

    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content("Sign Out")
  end

end

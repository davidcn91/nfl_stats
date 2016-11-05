feature 'user views teams', %Q{
  As a user
  I want to view a list of items
  So that I can pick a team to see its details
} do

  # * I should be able to view a list of teams from the root index.
  # * I should be able to click on any team to view its details.
  # * I should see the team information and game data from a team's detail page.

  scenario "user view list of teams" do
    team = FactoryGirl.create(:team)
    visit root_path
    expect(page).to have_content("Teams")
    expect(page).to have_link("#{team.location} #{team.name}")
  end

end

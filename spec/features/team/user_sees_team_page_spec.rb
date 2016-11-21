feature 'user views team page', %Q{
  As a user
  I want to view a team's page
  So that I can view its game history
} do

  # * I should be able to view a team's page by clicking a link from the root index.
  # * I should be able to see the team's name and all games it has played.
  # * I should be able to click a link for each game to view more details of that game.
  # * I should be able to choose any team from a dropdown on any page in the app.

  before(:each) do
    @team_1 = FactoryGirl.create(:team)
    @team_2 = FactoryGirl.create(:team, abbreviation: "DEN")
  end

  scenario "user clicks on team link" do
    visit root_path
    click_link "#{@team_1.location} #{@team_1.name}"

    expect(page).to have_content(@team_1.location)
    expect(page).to have_content(@team_1.name)
    expect(page).to have_content("Games")
  end

  scenario "user selects team from dropdown" do
    visit root_path
    select @team_1.name, from: "teams_name"
    click_button "teams_button"

    expect(page).to have_content(@team_1.location)
    expect(page).to have_content(@team_1.name)
    expect(page).to have_content("Games")

    select @team_2.name, from: "teams_name"
    click_button "teams_button"

    expect(page).to have_content(@team_2.location)
    expect(page).to have_content(@team_2.name)
    expect(page).to have_content("Games")
  end

end

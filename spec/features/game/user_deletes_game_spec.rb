feature 'user deletes game', %Q{
  As an authenticated user
  I want to delete a game
  So that its stats will not be counted
} do

  # * If I am the creator of a game, I should be able to destroy the Game.
  # * If I destroy the game, it should destroy all of its stats.
  # * If I am not the creator of the game or a site admin, I should not be able to destroy the Game.

  before(:each) do
    @team_1 = FactoryGirl.create(:team)
    @team_2 = FactoryGirl.create(:team, abbreviation: "KC")
    @user_1 = FactoryGirl.create(:user, team_id: @team_1.id)
    @user_2 = FactoryGirl.create(:user, team_id: @team_1.id, role: "admin")
    @user_3 = FactoryGirl.create(:user, team_id: @team_1.id)
    @game = FactoryGirl.create(:game, user_id: @user_1.id, away_team_id: @team_1.id, home_team_id: @team_2.id)
    @stat = FactoryGirl.create(:stat, game_id: @game.id)
  end

  scenario 'signed in user is the creator of the team' do
    sign_in(@user_1)
    click_link "#{@team_1.location} #{@team_1.name}"
    expect(page).to have_content("Week #{@game.week}: #{@game.away_team.name} #{@game.away_score} @ #{@game.home_team.name} #{@game.home_score}")

    click_button "Delete Game"
    expect(page).to have_content("Game deleted successfully!")

    click_link "#{@team_1.location} #{@team_1.name}"
    expect(page).to_not have_content("Week #{@game.week}: #{@game.away_team.name} #{@game.away_score} @ #{@game.home_team.name} #{@game.home_score}")
    expect(@game.stat).to be_nil
  end

  scenario 'signed in user is an admin' do
    sign_in(@user_2)
    click_link "#{@team_1.location} #{@team_1.name}"
    expect(page).to have_content("Week #{@game.week}: #{@game.away_team.name} #{@game.away_score} @ #{@game.home_team.name} #{@game.home_score}")

    click_button "Delete Game"
    expect(page).to have_content("Game deleted successfully!")

    click_link "#{@team_1.location} #{@team_1.name}"
    expect(page).to_not have_content("Week #{@game.week}: #{@game.away_team.name} #{@game.away_score} @ #{@game.home_team.name} #{@game.home_score}")
    expect(@game.stat).to be_nil
  end

  scenario 'signed in user is not creator of the team' do
    sign_in(@user_3)
    click_link "#{@team_1.location} #{@team_1.name}"
    expect(page).to have_content("Week #{@game.week}: #{@game.away_team.name} #{@game.away_score} @ #{@game.home_team.name} #{@game.home_score}")
    expect(page).to_not have_button("Delete Game")
  end

  scenario 'user is not signed in' do
    visit root_path
    click_link "#{@team_1.location} #{@team_1.name}"
    expect(page).to have_content("Week #{@game.week}: #{@game.away_team.name} #{@game.away_score} @ #{@game.home_team.name} #{@game.home_score}")
    expect(page).to_not have_button("Delete Game")
  end
end

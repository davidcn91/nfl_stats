class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :season, null: false
      t.integer :week, null: false
      t.integer :away_team_id, null: false
      t.integer :home_team_id, null: false
      t.integer :away_score, null: false
      t.integer :home_score, null: false
      t.float :spread, null: false
    end
  end
end

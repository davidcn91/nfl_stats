class CreateStats < ActiveRecord::Migration[5.0]
  def change
    create_table :stats do |t|
      t.integer :away_plays, null: false
      t.integer :away_yards, null: false
      t.integer :away_third_down_conversions, null: false
      t.integer :away_third_down_attempts, null: false
      t.integer :away_penalties, null: false
      t.integer :away_penalty_yards, null: false
      t.integer :away_rushes, null: false
      t.integer :away_rushing_yards, null: false
      t.integer :away_passes, null: false
      t.integer :away_passing_yards, null: false
      t.time :away_time_of_possession, null: false
      t.integer :away_fumbles, null: false
      t.integer :away_fumbles_lost, null: false
      t.integer :away_interceptions, null: false
      t.integer :home_plays, null: false
      t.integer :home_yards, null: false
      t.integer :home_third_down_conversions, null: false
      t.integer :home_third_down_attempts, null: false
      t.integer :home_penalties, null: false
      t.integer :home_penalty_yards, null: false
      t.integer :home_rushes, null: false
      t.integer :home_rushing_yards, null: false
      t.integer :home_passes, null: false
      t.integer :home_passing_yards, null: false
      t.time :home_time_of_possession, null: false
      t.integer :home_fumbles, null: false
      t.integer :home_fumbles_lost, null: false
      t.integer :home_interceptions, null: false
      t.integer :game_id, null: false
    end
  end
end

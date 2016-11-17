class RemoveTimeOfPossession < ActiveRecord::Migration[5.0]
  def up
    remove_column :stats, :away_time_of_possession
    remove_column :stats, :home_time_of_possession
  end

  def down
    add_column :stats, :away_time_of_possession, :string
    add_column :stats, :home_time_of_possession, :string
  end
end

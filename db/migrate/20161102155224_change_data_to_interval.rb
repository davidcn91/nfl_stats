class ChangeDataToInterval < ActiveRecord::Migration[5.0]
  def up
    change_column :stats, :away_time_of_possession, :interval
    change_column :stats, :home_time_of_possession, :interval
  end

  def down
    change_column :stats, :away_time_of_possession, :time
    change_column :stats, :home_time_of_possession, :time
  end
end

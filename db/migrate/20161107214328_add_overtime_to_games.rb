class AddOvertimeToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :overtime, :boolean, default: false
  end
end

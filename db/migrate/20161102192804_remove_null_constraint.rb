class RemoveNullConstraint < ActiveRecord::Migration[5.0]
  def up
    change_column :stats, :game_id, :integer, null: true
  end

  def down
    change_column :stats, :game_id, :integer, null: false
  end
end

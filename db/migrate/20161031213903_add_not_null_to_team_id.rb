class AddNotNullToTeamId < ActiveRecord::Migration[5.0]
  def up
    change_column_null :users, :team_id, false
  end

  def down
    change_column_null :users, :team_id, true
  end
end

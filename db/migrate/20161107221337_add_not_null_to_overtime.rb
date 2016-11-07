class AddNotNullToOvertime < ActiveRecord::Migration[5.0]
  def change
    change_column_null :games, :overtime, false
  end
end

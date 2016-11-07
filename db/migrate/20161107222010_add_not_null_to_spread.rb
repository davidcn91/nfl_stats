class AddNotNullToSpread < ActiveRecord::Migration[5.0]
  def change
    change_column_null :games, :spread, false
  end
end

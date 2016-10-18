class UpdateSpread < ActiveRecord::Migration[5.0]
  def up
    change_column :games, :spread, :decimal
  end

  def up
    change_column :games, :spread, :float
  end
end

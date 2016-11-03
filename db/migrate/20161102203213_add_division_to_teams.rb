class AddDivisionToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :division, :string
  end
end

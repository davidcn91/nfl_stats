class AddForeignKeys < ActiveRecord::Migration[5.0]
  def change
    def up
      add_foreign_key(:games, :away_team_id, :teams)
      add_foreign_key(:games, :home_team_id, :teams)
    end
    def down
      remove_foreign_key(:games, :away_team_id)
      remove_foreign_key(:games, :home_team_id)
    end
  end
end

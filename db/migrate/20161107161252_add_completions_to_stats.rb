class AddCompletionsToStats < ActiveRecord::Migration[5.0]
  def change
    add_column :stats, :away_completions, :integer, null: false
    add_column :stats, :home_completions, :integer, null: false
  end
end

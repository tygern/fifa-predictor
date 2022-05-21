class CreateMatchResults < ActiveRecord::Migration[7.0]
  def change
    create_table :match_results do |t|
      t.belongs_to :home_team, null: false, foreign_key: {to_table: :teams}
      t.integer :home_goals
      t.integer :home_red_cards
      t.belongs_to :away_team, null: false, foreign_key: {to_table: :teams}
      t.integer :away_goals
      t.integer :away_red_cards

      t.timestamps
    end
  end
end

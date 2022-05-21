class AddDiscardedAtToTeams < ActiveRecord::Migration[7.0]
  def change
    add_column :teams, :discarded_at, :datetime
    add_index :teams, :discarded_at
  end
end

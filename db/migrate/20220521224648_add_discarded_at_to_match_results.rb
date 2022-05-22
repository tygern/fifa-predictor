class AddDiscardedAtToMatchResults < ActiveRecord::Migration[7.0]
  def change
    add_column :match_results, :discarded_at, :datetime
    add_index :match_results, :discarded_at
  end
end

class AddDurationToMatchResults < ActiveRecord::Migration[7.0]
  def change
    add_column :match_results, :duration, :integer
  end
end

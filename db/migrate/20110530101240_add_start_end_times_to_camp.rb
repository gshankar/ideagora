class AddStartEndTimesToCamp < ActiveRecord::Migration
  def self.up
    add_column :camps, :time_zone, :string
    add_column :camps, :start_at, :datetime
    add_column :camps, :end_at, :datetime
  end

  def self.down
    remove_column :camps, :end_at
    remove_column :camps, :start_at
    remove_column :camps, :time_zone
  end
end

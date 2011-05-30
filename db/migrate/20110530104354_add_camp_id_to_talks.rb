class AddCampIdToTalks < ActiveRecord::Migration
  def self.up
    add_column :talks, :camp_id, :integer
  end

  def self.down
    remove_column :talks, :camp_id
  end
end

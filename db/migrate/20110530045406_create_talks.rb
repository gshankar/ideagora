class CreateTalks < ActiveRecord::Migration
  def self.up
    create_table :talks do |t|
      t.integer :venue_id
      t.integer :user_id
      t.string :name
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end

  def self.down
    drop_table :talks
  end
end

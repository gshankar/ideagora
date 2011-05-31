class CreateAttendances < ActiveRecord::Migration
  def self.up
    create_table :attendances do |t|
      t.integer :camp_id
      t.integer :user_id
      t.boolean :organiser, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :attendances
  end
end

class CreateCamps < ActiveRecord::Migration
  def self.up
    create_table :camps do |t|
      t.string :name
      t.string :location
      t.boolean :current

      t.timestamps
    end
  end

  def self.down
    drop_table :camps
  end
end

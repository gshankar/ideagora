class CreateNotices < ActiveRecord::Migration
  def self.up
    create_table :notices do |t|
      t.string :title
      t.text :content
      t.references :user
      t.references :camp
      t.boolean :enabled

      t.timestamps
    end
  end

  def self.down
    drop_table :notices
  end
end

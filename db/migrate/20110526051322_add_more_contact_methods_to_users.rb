class AddMoreContactMethodsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :bonjour, :string
    add_column :users, :irc, :string
  end

  def self.down
    remove_column :users, :irc
    remove_column :users, :bonjour
  end
end

class Camp < ActiveRecord::Base
  validates_presence_of :name, :current
  has_many :users
end

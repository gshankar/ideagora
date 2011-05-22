class Camp < ActiveRecord::Base
  validates_presence_of :name, :current
  has_many :users
  
  # TODO if one camp is enabled, all others should be disabled
end

class Camp < ActiveRecord::Base
  validates_presence_of :name, :current
  has_many :attendees, :class_name => 'Attendance'
  has_many :users, :through => :attendees
  
  # TODO if one camp is enabled, all others should be disabled
end

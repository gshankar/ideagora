class Camp < ActiveRecord::Base
  validates_presence_of :name, :current
  has_many :attendees, :class_name => 'Attendance'
  has_many :users, :through => :attendees
  has_many :notices
  
  def current?
    !! current
  end
  
  def self.current
    where(:current => true).first
  end
  
  # TODO if one camp is enabled, all others should be disabled
end

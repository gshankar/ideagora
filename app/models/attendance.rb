class Attendance < ActiveRecord::Base
  belongs_to :camp
  belongs_to :user

  validates_presence_of :camp_id, :user_id
end

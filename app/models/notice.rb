class Notice < ActiveRecord::Base
  belongs_to :user
  belongs_to :camp
  validates_presence_of :title, :content
end

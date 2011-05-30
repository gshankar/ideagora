class Venue < ActiveRecord::Base
  validates_presence_of :name
  belongs_to :camp
  has_many :talks
end

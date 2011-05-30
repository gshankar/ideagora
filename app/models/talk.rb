class Talk < ActiveRecord::Base
  belongs_to :user
  belongs_to :venue

  validates_presence_of :user_id
  validates_presence_of :venue_id
  validates_presence_of :start_at
  validates_presence_of :end_at
  validate :start_at_is_less_than_end_at

  private

  def start_at_is_less_than_end_at
    if start_at.blank? || end_at.blank? || start_at >= end_at
      errors.add :start_at, "The start time must be before the end time" 
    end
  end
end

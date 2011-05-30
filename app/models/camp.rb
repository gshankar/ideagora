class Camp < ActiveRecord::Base
  has_many :attendees, :class_name => 'Attendance'
  has_many :users, :through => :attendees
  has_many :venues
  has_many :talks

  validates_presence_of :name, :current, :time_zone, :start_at, :end_at
  validate :start_at_is_less_than_end_at

  after_create :create_talks_for_full_days_of_camp
  
  # TODO if one camp is enabled, all others should be disabled

  private

  def start_at_is_less_than_end_at
    if start_at.blank? || end_at.blank? || start_at >= end_at
      errors.add :start_at, "The start time must be before the end time" 
    end
  end

  def create_talks_for_full_days_of_camp
    #what hour should talks start and end at. 
    #TODO: move these magic numbers somewhere more configurable?
    talks_start_at = 10
    talks_end_at = 18

    first_talk_day = start_at.tomorrow.beginning_of_day
    last_talk_day = end_at.yesterday.beginning_of_day

    #bail if we have no days for talks, but this should never happen
    return if first_talk_day > last_talk_day

    #create talks for each day and hour that we should have talks
    number_of_days_with_talks = ((last_talk_day.end_of_day - first_talk_day).seconds / 1.day).to_i
    number_of_days_with_talks.times do |day_num|
      talks_start_at.upto(talks_end_at) do |hour|
        start_time = first_talk_day + day_num.days + hour.hours
        end_time = start_time + 1.hours

        talk = Talk.new(:camp => self, :start_at => start_time, :end_at => end_time)
        talk.save(:validate => false) #skip validations because we're not passing a venue or user id
      end
    end
  end
end

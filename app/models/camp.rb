class Camp < ActiveRecord::Base
  has_many :attendees, :class_name => 'Attendance'
  has_many :users, :through => :attendees
  has_many :venues
  has_many :talks, :through => :venues

  validates_presence_of :name, :current, :time_zone, :start_at, :end_at
  validate :start_at_is_less_than_end_at

  # TODO if one camp is enabled, all others should be disabled
  
  def self.current
    where(:current => true).take(1).first
  end

  def talks_by_day
    #OPTIMIZE: this is ghetto and could be done nicer in sql instead of ruby, but this is quick and dirty for now
    tbd = ActiveSupport::OrderedHash.new

    talks.collect{|t| t.start_at.to_date}.uniq.sort.each do |date|
      tbd[date] = talks.where('start_at >= ? and start_at < ?', date, date + 1.day).order(:start_at)
    end

    return tbd
  end

  def talks_by_time_and_venue_for_day(day)
    #We want to return an ordered hash like { :time => { :venue => :talk } }
    talks_by_time = ActiveSupport::OrderedHash.new

    talks_for_day = talks.for_day(day)
    times = talks_for_day.collect(&:start_at).uniq
    venues = talks_for_day.collect(&:venue).uniq

    #Key up all the times
    times.each do |time|
      talks_by_time[time] = ActiveSupport::OrderedHash.new
    end

    #Slot the talks by time, by venue
    talks_for_day.each do |talk|
      talks_by_time[talk.start_at][talk.venue] = talk
    end

    return talks_by_time
  end

  def talk_hours
    #TODO: decide if we want to move this to a config var, or store it in the db per-camp. discuss with Elle
    10.upto(18).to_a
  end

  def talk_days
    first_talk_day = start_at.tomorrow.beginning_of_day
    last_talk_day = end_at.yesterday.beginning_of_day
    number_of_days_with_talks = ((last_talk_day.end_of_day - first_talk_day).seconds / 1.day).to_i

    days = []
    number_of_days_with_talks.times {|i| days << first_talk_day.to_date + i.days}
    return days
  end

  private

  def start_at_is_less_than_end_at
    if start_at.blank? || end_at.blank? || start_at >= end_at
      errors.add :start_at, "The start time must be before the end time" 
    end
  end

end

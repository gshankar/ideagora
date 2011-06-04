class TalksController < InheritedResources::Base
  before_filter :requires_login

  def index
    @day = params[:day] ? Date.parse(params[:day]) : Camp.current.talks.order(:start_at).first.day
    @venues = Camp.current.venues
    @days_with_talks = Camp.current.talks.collect(&:day).uniq.sort
    @talks_by_time_and_venue_for_day = Camp.current.talks_by_time_and_venue_for_day(@day)
    index!
  end

  def new
    @users = Camp.current.users.order(:first_name)
    @start_at = Time.parse(params[:start_at])
    @end_at = @start_at + 1.hour
    @venue = Venue.find(params[:venue_id])
    @talk = Talk.new(:start_at => @start_at, :end_at => @end_at, :venue => @venue, :user => current_user)
    new!
  end

  def edit
    @users = Camp.current.users.order(:first_name)
    edit!
  end

  def create
    @talk = Talk.new(params[:talk])
    @talk.user = current_user
    create!
  end
end

class TalksController < InheritedResources::Base
  before_filter :requires_login

  def index
    @day = params[:day] ? Date.parse(params[:day]) : Camp.current.talks.order(:start_at).first.day
    @venues = Camp.current.venues
    @talks_by_time_and_venue_for_day = Camp.current.talks_by_time_and_venue_for_day(@day)
    index!
  end

  def create
    @talk = Talk.new(params[:talk])
    @talk.user = current_user
    create!
  end
end

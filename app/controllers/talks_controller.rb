class TalksController < InheritedResources::Base
  before_filter :requires_login

  def index
    @talks_by_day = Camp.current.talks_by_day
    index!
  end

  def create
    @talk = Talk.new(params[:talk])
    @talk.user = current_user
    create!
  end
end

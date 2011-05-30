class TalksController < InheritedResources::Base
  before_filter :requires_login

  def create
    @talk = Talk.new(params[:talk])
    @talk.user = current_user
    create!
  end
end

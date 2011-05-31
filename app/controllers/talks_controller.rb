class TalksController < InheritedResources::Base
  before_filter :requires_login, :except => [:index, :show]

  def create
    @talk = Talk.new(params[:talk])
    @talk.user = current_user
    create!
  end
end

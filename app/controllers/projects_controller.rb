class ProjectsController < InheritedResources::Base
  before_filter :requires_login
  before_filter :set_owner, :only => [:create, :update]
  
  private
  def set_owner
    resource.owner = current_user
  end
end

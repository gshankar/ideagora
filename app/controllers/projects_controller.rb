class ProjectsController < InheritedResources::Base
  before_filter :requires_login
  before_filter :set_owner, :only => [:create, :update]
  
  def create
    create! { user_path(current_user) }
  end
  
private
  def set_owner
    @project = Project.new(params[:project])
    @project.owner = current_user
  end
  
  def collection
    @projects ||= if current_user
                    current_user.projects
                  else
                    Project.all
                  end
  end
end

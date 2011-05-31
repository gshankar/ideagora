class ProjectsController < InheritedResources::Base
  before_filter :requires_login, :except => [:index, :show]
  before_filter :requires_owner, :except => [:index, :show, :new, :create]
  
  
  def create
    @project = Project.new(params[:project])
    @project.owner = current_user
    create! { user_path(current_user) }
  end
  
  def update
    update! { user_path(current_user) }
  end
  
private
  def requires_owner
    unless is_owner?
      redirect_to :back
      flash[:alert] = 'You cannot edit projects that are not yours'
    end
  end
  
  def is_owner?
    resource.owner == current_user
  end
  helper_method :is_owner?
  
  def collection
    @projects ||= if current_user
                    current_user.projects
                  else
                    Project.all
                  end
  end
end

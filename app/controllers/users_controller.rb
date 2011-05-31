class UsersController < InheritedResources::Base
  actions :index, :show, :update
  before_filter :requires_login, :except => [:index, :show]

  def edit
    @user = current_user
    @skills_tags_json = User.tag_counts_on(:skills).to_json
    @interests_tags_json = User.tag_counts_on(:interests).to_json
  end

  def update
    update! { my_profile_path }
  end
end

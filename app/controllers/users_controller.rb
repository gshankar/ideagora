class UsersController < InheritedResources::Base
  actions :index, :show, :edit, :update
  before_filter :requires_login

end

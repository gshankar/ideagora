require 'acceptance/acceptance_helper'

describe 'User\'s projects', :type => :request do
  before do
    @c = Camp.make!
    @u = @c.users.make!
    sign_in_as(@u)
  end

  context 'when logged in' do
    it "should not create a project without a name" do
      pending
    end
    
    
    it 'creates project with owner as current_user' do
      visit user_path(@u)
      page.should have_content('Add new project')
      click_link 'Add new project'
      
      page.should have_content('Create a new project')
      
      attrs = { 
        :name => 'Happy campers',
        :description => 'App for railscamps',
      }
      
      attrs.each do |attr, value|
        fill_in attr.to_s.humanize, :with => value
      end
      
      page.click_button 'Create Project'
      
      current_path.should == user_path(@u)
      page.should have_content('Happy campers')

      # check flash
      # assert that a new project was created
      # assert tha current_user.projects.count changed by 1
    end
  end

  context 'when not logged in' do
    it 'can see /projects'
    it 'can see /users/1/projects'
    it 'cannot access /users/1/projects/new'
  end
end

require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Authentication", %q{
  In order to take part in rc activities
  As a rails peep
  I want to be able to log in
} do
  
  background do
    @c = Camp.make!
    @u = @c.users.make
    @u.update_attribute(:twitter, @u.first_name)
    visit sign_in
    page.should have_content('Sign in')
  end

  scenario "current railscamp peep with email" do
    fill_in 'details', :with => @u.email
    click_button 'Let me in'
    page.should have_content('Logged in!')
  end
  
  scenario "current railscamp peep with twitter username" do
    fill_in 'details', :with => @u.twitter
    click_button 'Let me in'
    page.should have_content('Logged in!')
  end
  
  scenario "peep from a previous camp" do
    pending
  end
  
  scenario "other person" do
    other = User.make
    fill_in 'details', :with => other.email
    click_button 'Let me in'
    page.should have_content('Cannot log you in.')
  end
  
  scenario "not logged in, trying to access @u profile page" do
    visit my_profile_path
    current_path.should == root_path
    page.should have_content('Unauthorised!')
  end
end

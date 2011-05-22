require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Authentication", %q{
  In order to take part in rc activities
  As a rails peep
  I want to be able to log in
} do

  scenario "current railscamp peep with email" do
    c = Camp.make!
    u = c.users.make
    u.save
    visit sign_in
    page.should have_content('Sign in')
    fill_in 'details', :with => u.email
    click_button 'Let me in'
    page.should have_content('Logged in!')
  end
  
  scenario "current railscamp peep with twitter username" do
    c = Camp.make!
    u = c.users.make
    u.update_attribute(:twitter, u.first_name)
    u.save
    visit sign_in
    page.should have_content('Sign in')
    fill_in 'details', :with => u.twitter
    click_button 'Let me in'
    page.should have_content('Logged in!')
  end
  
  scenario "non-current railscamp peep" do
    pending
  end
  
  scenario "other person" do
    u = User.make
    visit sign_in
    page.should have_content('Sign in')
    fill_in 'details', :with => u.email
    click_button 'Let me in'
    page.should have_content('Cannot log you in.')
  end
  
end

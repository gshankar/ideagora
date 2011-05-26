module HelperMethods
  # Put helper methods you need to be available in all tests here.
  def sign_in_as(user)
    visit sign_in_path
    fill_in 'details', :with => @u.email
    click_button 'Let me in'
  end

  def clear_db
    models = %w(user camp attendance)
    models.each{|m| m.capitalize.constantize.delete_all }
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
RSpec.configuration.include HelperMethods, :type => :request #for capybara rspec

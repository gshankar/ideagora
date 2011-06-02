require 'acceptance/acceptance_helper'

describe 'users CRUDing talks', :type => :request do
  before do
    @camp = Camp.current || Camp.make!
    @user = @camp.users.make!
    sign_in_as(@user)
  end

  it 'lets users view the talks' do
    venue = Venue.make!(:camp => @camp)
    talk = venue.talks.create(:name => 'Sample Talk', :venue => venue, :user => @user, :start_at => @camp.start_at.to_date + 1.day + 10.hours, :end_at => @camp.start_at.to_date + 1.day + 11.hours)

    viewing_day = @camp.talks.order(:start_at).first.day
    visit talks_path(:day => viewing_day)

    # Do we see the details for each talk on this day?
    @camp.talks.for_day(viewing_day).each do |talk|
      page.should have_content talk.name
    end

    #We should have links for the other talk days
    @camp.talks.collect(&:day).uniq.each do |day|
      page.should have_link day.strftime("%A") unless day == viewing_day
    end
  end

  it 'lets a user create a new talk' do
    visit talks_path(:day => @camp.start_at.to_date + 1.day)
    click_link 'Add Talk'

    fill_in :name, :with => 'New Title'

    click_button 'Create Talk'

    #saved flash?
    page.should have_content 'Talk was successfully created.'

    #new values saved?
    page.should have_content 'New Title'
  end
end

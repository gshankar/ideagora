require 'spec_helper'

describe Camp do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:current) }
  it { should validate_presence_of(:time_zone) }
  it { should validate_presence_of(:start_at) }
  it { should validate_presence_of(:end_at) }

  it { should have_many(:attendees) }
  it { should have_many(:venues) }
  it { should have_many(:talks) }

  describe '#talks_by_time_and_venue_for_day(day)' do
    before do
      @camp = Camp.make!
      venue = Venue.make!(:camp => @camp)
      user = User.make! #Why won't @camp.users.make! work? I wish I knew Machinist2...
      @camp.users << user
      talk = venue.talks.create(:name => 'Sample Talk', :venue => venue, :user => user, :start_at => @camp.start_at.to_date + 1.day + 10.hours, :end_at => @camp.start_at.to_date + 1.day + 11.hours)
    end

    it 'returns an OrderedHash in the form of { :time => { :venue => :talk } }' do
      talks = @camp.talks_by_time_and_venue_for_day(@camp.start_at.to_date + 1.days)

      talks.should be_a_kind_of ActiveSupport::OrderedHash
      talks.keys.first.should be_a_kind_of Time

      talks_for_time = talks[talks.keys.first]
      talks_for_time.keys.first.should be_a_kind_of Venue

      talk = talks_for_time[talks_for_time.keys.first]
      talk.should be_a_kind_of Talk
    end
  end
end

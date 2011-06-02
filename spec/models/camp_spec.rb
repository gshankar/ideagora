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

  it 'creates Talks after it is created' do
    zone = 'Sydney'
    Time.zone = zone
    start_at = Time.zone.parse '2011-06-10 16:00:00'
    end_at  =  Time.zone.parse '2011-06-13 10:00:00'

    c = Camp.make!(:time_zone => zone, :start_at => start_at, :end_at => end_at)
    c.talks.should_not be_empty
    c.talks.count.should == 18 # 2 days of talks in the example start/end above, talks from 10 through 6pm daily

    #no talks on the first night or the last day
    c.talks.where('start_at < ?', c.start_at.end_of_day).count.should == 0
    c.talks.where('start_at > ?', c.end_at.beginning_of_day).count.should == 0
  end

  describe '#talks_by_day' do
    let!(:camp) { Camp.make! }
    let!(:venue) { camp.venues.make! }
    let!(:user) { camp.users.make! }
    let!(:day_1_talk_1) { camp.talks.first }
    let!(:day_1_talk_2) { camp.talks.second }
    let!(:day_2_talk_1) { camp.talks.last }
    let!(:tbd) { camp.talks_by_day }

    it 'returns an OrderedHash of talks keyed by day' do
      tbd.should be_kind_of(ActiveSupport::OrderedHash)

      #SOMEDAY: test the order of the keys in this hash

      tbd[day_1_talk_1.start_at.to_date].should include(day_1_talk_1, day_1_talk_2)
      tbd[day_1_talk_1.start_at.to_date].should_not include(day_2_talk_1)

      tbd[day_2_talk_1.start_at.to_date].should include(day_2_talk_1)
      tbd[day_2_talk_1.start_at.to_date].should_not include(day_1_talk_1, day_1_talk_2)
    end

    #SOMEDAY: test the order of the values in this hash
  end

  describe '#talks_by_time_and_venue_for_day(day)' do
    let!(:camp) { Camp.make! }
    let!(:venue) { camp.venues.make! }
    let!(:user) { camp.users.make! }

    before do
      #Create talks with venues for each talk slot at the camp
      camp.talks.each {|t| t.update_attributes(:venue => venue, :user => user, :name => 'Fake talk')}
    end

    it 'returns an OrderedHash in the form of { :time => { :venue => :talk } }' do
      talks = camp.talks_by_time_and_venue_for_day(camp.start_at.to_date + 1.days)

      talks.should be_a_kind_of ActiveSupport::OrderedHash
      talks.keys.first.should be_a_kind_of Time

      talks_for_time = talks[talks.keys.first]
      talks_for_time.keys.first.should be_a_kind_of Venue

      talk = talks_for_time[talks_for_time.keys.first]
      talk.should be_a_kind_of Talk
    end
  end
end

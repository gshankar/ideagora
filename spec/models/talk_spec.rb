require 'spec_helper'

describe Talk do
  it { should belong_to :user }
  it { should belong_to :venue }

  describe 'validations' do
    before do 
      @talk = Talk.make
    end

    it { should validate_presence_of :start_at }
    it { should validate_presence_of :end_at }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :venue_id }

    it 'ensures end_at > start_at' do
      @talk.update_attributes :start_at => 1.day.ago, :end_at => 1.day.from_now
      @talk.should be_valid
      @talk.update_attributes :start_at => 1.day.from_now, :end_at => 1.day.ago
      @talk.should be_invalid
      @talk.should have(1).errors_on(:start_at)
    end
  end
end

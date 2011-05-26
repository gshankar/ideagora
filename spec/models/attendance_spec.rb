require 'spec_helper'

describe Attendance do
  it { should belong_to(:user) }
  it { should belong_to(:camp) }
  it { should validate_presence_of(:camp_id) }
  it { should validate_presence_of(:user_id) }
end

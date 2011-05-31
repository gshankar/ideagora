require 'spec_helper'

describe Notice do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
  it { should belong_to(:user) }
  it { should belong_to(:camp) }
  
end

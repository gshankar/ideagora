require 'spec_helper'

describe Camp do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:current) }
  it { should have_many(:attendees) }
  it { should have_many(:notices) }
end

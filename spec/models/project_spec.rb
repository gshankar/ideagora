require 'spec_helper'

describe Project do
  it { should validate_presence_of(:name) }
  it { should belong_to(:owner) }
  
  it { should be_invalid }
  context 'when new project' do
    context 'without name' do
      subject { Project.create }
      it { should have(2).errors }
      specify { subject.errors_on(:name).should include("can't be blank") }
      specify { subject.errors_on(:owner).should include("can't be blank") }
    end
    
    context 'with name' do
      subject { Project.make }
      it { should be_valid }
    end
  end
end

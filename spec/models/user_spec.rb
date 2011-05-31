require 'spec_helper'

describe User do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:email) }
  it { should have_many(:projects).dependent(:destroy) }
  it { should have_many(:camps) }
  it { should have_many(:notices) }
  
  it { should be_invalid }  

  it 'has skills tags' do
    user = User.make!
    user.update_attribute(:skill_list, 'rspec, javascript')
    user.skill_list.should include('rspec', 'javascript')
  end

  it 'has interests tags' do
    user = User.make!
    user.update_attribute(:interest_list, 'running, game-dev')
    user.interest_list.should include('running', 'game-dev')
  end

  context 'when new user' do
    context 'without first name, email or password' do
      subject { User.create }
      it { should have(2).errors }
      specify { subject.errors_on(:first_name).should include("can't be blank") }
      specify { subject.errors_on(:email).should include("can't be blank") }
    end
    
    context 'with first name, email or password' do
      subject { User.make }
      it { should be_valid }
    end
    
    context 'when existing user' do
      before do
        @existing =  User.make!
        @user = User.make(:email => @existing.email)
      end
      
      specify { @user.should_not be_valid }
      specify { @user.errors_on(:email).should include("has already been taken") }
      specify { lambda { @user.save }.should_not change(User, :count) }
      
      it "should allow unique email" do
        @user.email = 'different_email@different_domain.com'
        @user.should be_valid
        lambda { @user.save }.should change(User, :count).by(1)
      end
    end
  end
  
  context 'full_name' do
    before { @user = User.make!(:first_name => 'elmo', :last_name => nil) }
    specify { @user.full_name.should == 'elmo' }
    
    it "should concat first and last name" do
      @user.update_attribute(:last_name, 'smith')
      @user.full_name.should == 'elmo smith'
    end
  end
end

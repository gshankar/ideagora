require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the UsersHelper. For example:
#
# describe UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe UsersHelper do
  describe "#get_gravatar" do
    before do
      @user = User.create(:first_name => "User", :email => "user@test.com")
    end

    it 'returns an expected image url to gravatar with correctly hashed email' do
      email_md5 = Digest::MD5.hexdigest(@user.email).to_s
      url = "http://www.gravatar.com/avatar/" + email_md5 + "?s=" + 80

      get_gravatar(@user, 80).should == url
    end
  end
end

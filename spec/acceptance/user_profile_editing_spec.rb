require 'acceptance/acceptance_helper'

describe 'A user viewing and editing their profile', :type => :request do
  before do
    @c = Camp.make!
    @u = @c.users.make!
    sign_in_as(@u)
  end

  context 'when a user views their profile page' do
    it 'shows them their profile info' do
      visit my_profile_path

      #showing all our attributes in editable fields?
      profile_attrs = %w(first_name last_name email bio twitter bonjour irc)
      profile_attrs.each do |attr|
        page.should have_field(attr.humanize, :with => @u.send(attr))
      end

      page.should have_field('Skill list',    :with => @u.skill_list.sort.join(', '))
      page.should have_field('Interest list', :with => @u.interest_list.sort.join(', '))
    end
  end

  context 'when a user updates their profile' do
    it 'saves the new values and shows them the edit page again' do
      visit my_profile_path

      new_attrs = { 
        :first_name => 'GabeNew',
        :last_name => 'HollombeNew',
        :email => 'gabenew@railscampers.com',
        :bio => 'New bio',
        :twitter => 'gabehollombenew',
        :bonjour => 'bonjournew',
        :irc => 'ircnew',
        :skill_list => 'javascriptnew, rspecnew',
        :interest_list => 'divingnew, game-devnew'
      }

      new_attrs.each do |attr, new_value|
        fill_in attr.to_s.humanize, :with => new_value
      end

      page.click_button 'Save changes'

      #redirected back on edit page?
      current_path.should == my_profile_path

      #new values saved?
      new_attrs.each do |attr, new_value|
        page.should have_field(attr.to_s.humanize, :with => new_value)
      end
    end
  end
end

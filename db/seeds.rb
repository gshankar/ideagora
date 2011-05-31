# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

Camp.create!(:name => 'Railscamp 9', :location => 'Lake Ainsworth, Lennox Head, NSW', :current => true)
['Library', 'Lake View Conference Room - North', 'Lake View Conference Room - South'].each { |v| Venue.create!(:name => v, :camp => Camp.first) }

require 'csv'
filename = File.join(Rails.root.to_s, 'db', 'seeds', 'rc9_attendees.csv')

CSV.foreach(filename, :headers => true) do |row|
  u = User.create(:first_name => row['first_name'],
                  :last_name => row['last_name'],
                  :email => row['email'],
                  :twitter => row['twitter'],
                  :camps => [Camp.first]
                  )
  puts "created #{u.first_name} #{u.last_name}"
end


%w(ben@hoskings.net
ellemeredith@gmail.com
gabe@avantbard.com
jason@codespike.com
jason.stirk@rubyx.com
kpitty@cockatoosoftware.com.au
scottandrewharvey@gmail.com
tim@mcewan.it
zubin@wickedweasel.com).each do |email|
  puts "Setting #{email} as organiser"
  User.find_by_email!(email).attendances.first.update_attribute(:organiser, true)
end

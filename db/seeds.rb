# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

rc9 = Camp.create!(:name => 'Railscamp 9', :location => 'Lake Ainsworth, Lennox Head, NSW', :current => true)

['Library', 'Lake View Conference Room - North', 'Lake View Conference Room - South'].each { |v| Venue.create!(:name => v, :camp => rc9) }

rc9_day_1 = Time.parse('2011-06-01')
rc9_day_2 = rc9_day_1 + 1.days

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

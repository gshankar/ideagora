# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

rc9 = Camp.find_by_name('Railscamp 9') || Camp.create(:name => 'Railscamp 9', :location => 'Lake Ainsworth, Lennox Head, NSW', :current => true, :time_zone => 'Sydney', :start_at => '2011-06-10 16:00:00', :end_at => '2011-06-13 10:00:00')

['Library', 'Lake View Conference Room - North', 'Lake View Conference Room - South'].each { |v| rc9.venues.create!(:name => v) unless rc9.venues.find_by_name(v) }

require 'csv'
filename = File.join(Rails.root.to_s, 'db', 'seeds', 'rc9_attendees.csv')
puts "Making sure we have some users for #{rc9.name}..."
CSV.foreach(filename, :headers => true) do |row|
  if rc9.users.find_by_email(row['email']).nil?
    puts "Creating #{row['first_name']} #{row['last_name']}"
    u = rc9.users.create!(
      :first_name => row['first_name'],
      :last_name => row['last_name'],
      :email => row['email'],
      :twitter => row['twitter']
    )
  end
end
puts "Done with users."

#fake some talks
venues = rc9.venues
users = rc9.users
rc9.talks.each_with_index do |talk, index|
  next if index % 4 == 0 #skip some talk slots

  venue = venues[index % venues.length]
  speaker = users[index % users.length]

  talk.update_attributes(
    :venue_id => venue.id,
    :user_id => speaker.id,
    :name => "Fake Talk #{index}"
  )
  puts "Updated talk #{talk.name}"
end

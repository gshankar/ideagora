# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Camp.create!(:name => 'Railscamp 9', :location => 'Lake Ainsworth, Lennox Head, NSW', :current => true)
['Library', 'Lake View Conference Room - North', 'Lake View Conference Room - South'].each { |v| Venue.create!(:name => v, :camp => Camp.first) }
require 'machinist/active_record'
require 'faker'

Camp.blueprint do
  name          { 'Railscamp 9' }
  current       { true }
end

Camp.blueprint(:previous) do
  name          { 'Railscamp 8' }
  current       { false }
end

Project.blueprint do
  name          { Faker::Lorem.words(1) }
  owner         { User.make! }
end

User.blueprint do
  first_name    { Faker::Name.name }
  email         { Faker::Internet.email }
end

Venue.blueprint do
  name          { Faker::Lorem.words(1) }
end

Talk.blueprint do
  name     { 'Introduction to Coffeescript' }
  venue    { Venue.make! }
  user     { User.make! }
  start_at { 1.day.ago }
  end_at   { 1.day.from_now }
end

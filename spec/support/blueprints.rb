require 'machinist/active_record'
require 'faker'

Camp.blueprint do
  name          { 'Railscamp 9' }
  current       { true }
  time_zone     { 'Sydney' }
  start_at      { 1.day.ago.beginning_of_day + 16.hours }
  end_at        { 2.days.from_now.beginning_of_day + 10.hours }
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
  first_name       { Faker::Name.name }
  last_name        { Faker::Name.name }
  email            { Faker::Internet.email }
  twitter          { Faker::Name.name }
  bio              { Faker::Name.name }
  skill_list       { 'skill_a, skill_b' }
  interest_list    { 'interest_a, interest_b' }
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

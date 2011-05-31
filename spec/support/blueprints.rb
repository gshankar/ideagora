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


Notice.blueprint do
  title         { Faker::Name.name }
  content       { Faker::Lorem.sentences }
  user          { User.make! }
  camp          { Camp.make! }
end

Project.blueprint do
  name          { Faker::Lorem.words(1) }
  owner         { User.make! }
end

Talk.blueprint do
  name     { 'Introduction to Coffeescript' }
  venue    { Venue.make! }
  user     { User.make! }
  start_at { 1.day.ago }
  end_at   { 1.day.from_now }
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

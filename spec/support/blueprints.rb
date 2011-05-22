require 'machinist/active_record'
require 'faker'

Project.blueprint do
  name          { Faker::Lorem.words(1) }
  owner         { User.make! }
end

User.blueprint do
  first_name    { Faker::Name.name }
  email         { Faker::Internet.email }
end

FactoryBot.define do
  factory :user do
    email                 { Faker::Internet.email }
    password              { "abcd1234" }
    password_confirmation { "abcd1234" }
    first_name            { Faker::Name.name }
    last_name             { Faker::Name.name }
    birthday              { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end 
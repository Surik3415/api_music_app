# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::Name.first_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }
  end
end

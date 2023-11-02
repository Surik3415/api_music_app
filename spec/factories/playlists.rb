# frozen_string_literal: true

FactoryBot.define do
  factory :playlist do
    user
    name { Faker::Music::GratefulDead.song }
    description { Faker::Lorem.paragraph }
    likes { 0 }
    sharable_type { 0 }
    access_type { 'private' }
    featured { false }
  end
end

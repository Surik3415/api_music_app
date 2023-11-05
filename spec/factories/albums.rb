# frozen_string_literal: true

FactoryBot.define do
  factory :album do
    name { FFaker::Music.album }
    genre
  end
end

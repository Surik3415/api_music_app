# frozen_string_literal: true

FactoryBot.define do
  factory :song do
    name { FFaker::Music.unique.song }
    album
    genre
  end
end

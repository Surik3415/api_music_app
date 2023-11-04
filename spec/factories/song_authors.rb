# frozen_string_literal: true

FactoryBot.define do
  factory :song_author do
    song
    author
  end
end

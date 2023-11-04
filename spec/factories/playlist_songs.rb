# frozen_string_literal: true

FactoryBot.define do
  factory :playlist_song do
    playlist
    song
  end
end

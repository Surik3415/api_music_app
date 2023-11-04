# frozen_string_literal: true

FactoryBot.define do
  factory :album_author do
    album
    author
  end
end

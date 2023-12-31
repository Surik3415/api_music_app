# frozen_string_literal: true

FactoryBot.define do
  factory :friend_request do
    sender factory: %i[user]
    receiver factory: %i[user]
  end
end

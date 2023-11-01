# frozen_string_literal: true

module Api
  module V1
    class FriendshipSerializer < ApplicationSerializer
      attribute :become_a_frinds_at, &:created_at
      attribute :user_info do |object|
        return Api::V1::UserSerializer.new(object.friend)
      end
    end
  end
end

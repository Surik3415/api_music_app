# frozen_string_literal: true

module Api
  module V1
    class FriendRequestSerializer < ApplicationSerializer
      attribute :request_submitted_at, &:created_at
      attribute :user_info do |object, params|
        return Api::V1::UsersSerializer.new(object.sender) if params == 'recieved'

        Api::V1::UsersSerializer.new(object.receiver)
      end
    end
  end
end

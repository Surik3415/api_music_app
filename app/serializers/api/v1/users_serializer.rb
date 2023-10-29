# frozen_string_literal: true

module Api
  module V1
    class UsersSerializer < ApplicationSerializer
      attributes :username, :email
      attribute :registrated_at, &:created_at
    end
  end
end

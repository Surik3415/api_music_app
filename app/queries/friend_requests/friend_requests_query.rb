# frozen_string_literal: true

module FriendRequests
  class FriendRequestsQuery < ApplicationQuery
    attr_reader :requests, :tab, :user

    TAB_CASES = { received: :received_friend_requests, sent: :sent_friend_requests }.freeze

    def self.call(params:, requests:, user:)
      new(requests: requests, params: params, user: user).call
    end

    def initialize(requests:, params:, user:)
      @requests = requests
      @tab = params.fetch(:tab, nil)&.to_sym
      @user = user
      super
    end

    def call
      take_request_by_tab
    end

    private

    def take_request_by_tab
      TAB_CASES[tab].nil? ? FriendRequest.none : user.public_send(TAB_CASES[tab])
    end
  end
end

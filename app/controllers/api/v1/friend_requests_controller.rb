# frozen_string_literal: true

module Api
  module V1
    class FriendRequestsController < AuthenticateController
      include Pagy::Backend
      ITEMS = 15

      def index
        requests = FriendRequest.all.includes(%i[sender receiver])
        requests = FriendRequests::FriendRequestsQuery.call(requests: requests, user: current_user,
                                                            params: params)

        pagy, records = pagy(requests, items: ITEMS)

        options = { meta: pagy_metadata(pagy) }

        render json: Api::V1::FriendRequestSerializer.new(records, options)
      end

      def create
        receiver = User.find_by(email: friend_params[:email])
        return not_found if not_valid_friend_request?(current_user, receiver)

        friend_request = current_user.sent_friend_requests.build(receiver: receiver)

        if same_request_exists?(current_user, receiver)
          render json: { error: 'same friend request already exists, check received requests' },
                 status: :not_found
        else
          friend_request.save
          render json: FriendRequestSerializer.new(friend_request)
        end
      end

      private

      def not_valid_friend_request?(current_user, receiver)
        receiver.nil? || current_user.friends.include?(receiver)
      end

      def same_request_exists?(current_user, receiver)
        FriendRequest.exists?(sender: current_user, receiver: receiver) ||
          FriendRequest.exists?(sender: receiver, receiver: current_user)
      end

      def friend_params
        params.permit(:email)
      end
    end
  end
end

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
        return render_not_found if receiver.nil?

        friend_request = current_user.sent_friend_requests.build(receiver: receiver)

        if same_request_exists?(friend_request)
          render json: { error: 'same friend request already exists, check received requests',
                         status: :conflict }
        else
          friend_request.save
          render json: FriendRequestSerializer.new(friend_request)
        end
      end

      private

      def same_request_exists?(friend_request)
        FriendRequest.exists?(
          { sender: current_user, receiver: friend_request.receiver }
          .or(sender: friend_request.receiver, receiver: current_user)
        )
      end

      def friend_params
        params.permit(:email)
      end
    end
  end
end

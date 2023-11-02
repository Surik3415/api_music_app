# frozen_string_literal: true

module Api
  module V1
    class FriendshipsController < AuthenticateController
      before_action :authorize_access_request!, only: %i[index create destroy]
      include Pagy::Backend

      ITEMS = 15

      def index
        friendships = current_user.friendships.includes(:friend)

        pagy, records = pagy(friendships, items: ITEMS)

        options = { meta: pagy_metadata(pagy) }

        render json: Api::V1::FriendshipSerializer.new(records, options)
      end

      def create
        friend_reauest = current_user.received_friend_requests.find_by(id: params[:id])
        return not_found if friend_reauest.nil?

        if current_user.friends.include?(friend_reauest.sender)
          render json: { error: 'Friendship already exists', status: :not_found }
        else
          create_friendship(current_user, friend_reauest.sender)
          friend_reauest.destroy
        end
      end

      def destroy
        friendship = current_user.friendships.find_by(id: params[:id])
        return not_found if friendship.nil?

        depend_friendship = Friendship.find_by(user_id: friendship.friend_id,
                                               friend_id: current_user.id)
        Friendship.transaction do
          friendship.destroy
          depend_friendship&.destroy
        end

        head :no_content
      end

      private

      def create_friendship(user, friend)
        friendship1 = user.friendships.build(friend_id: friend.id)
        friendship2 = friend.friendships.build(friend_id: user.id)

        friendship1.save && friendship2.save
        render json: { message: FriendshipSerializer.new(friendship1) }
      end
    end
  end
end

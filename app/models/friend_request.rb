# frozen_string_literal: true

class FriendRequest < ApplicationRecord
  belongs_to :sender, class_name: 'User', inverse_of: :sent_friend_requests
  belongs_to :receiver, class_name: 'User', inverse_of: :received_friend_requests
end

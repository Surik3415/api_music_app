# frozen_string_literal: true

class User < ApplicationRecord
  include ImageUploader::Attachment(:image)
  include UserValidationsConcern
  has_secure_password
  has_many :playlists

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, dependent: :destroy
  has_many :sent_friend_requests, class_name: 'FriendRequest', foreign_key: :sender_id,
                                  dependent: :destroy, inverse_of: :sender
  has_many :received_friend_requests, class_name: 'FriendRequest', foreign_key: :receiver_id,
                                      dependent: :destroy, inverse_of: :receiver
end

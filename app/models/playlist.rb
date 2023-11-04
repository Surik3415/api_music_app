# frozen_string_literal: true

class Playlist < ApplicationRecord
  include ImageUploader::Attachment(:image)

  belongs_to :user
  has_many :playlist_songs
  has_many :songs, through: :playlist_songs

  enum access_type: { private: 'private', public: 'public', only_friend: 'only_friend' },
       _prefix: true
  enum sharable_type: { closed: 0, open: 1 }

  validates :name, length: { in: 3..50 }, presence: true
  validates :description, length: { in: 3..250 }
end

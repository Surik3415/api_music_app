# frozen_string_literal: true

class Song < ApplicationRecord
  has_many :song_authors
  has_many :authors, through: :song_authors
  belongs_to :album
  belongs_to :genre
  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs

  validates :name, presence: true
end

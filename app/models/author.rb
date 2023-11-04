# frozen_string_literal: true

class Author < ApplicationRecord
  has_many :song_authors
  has_many :songs, through: :song_authors
  has_many :album_authors
  has_many :albums, through: :album_authors
  validates :name, presence: true
end

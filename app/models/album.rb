# frozen_string_literal: true

class Album < ApplicationRecord
  has_many :album_authors
  has_many :authors, through: :album_authors
  has_many :songs

  validates :name, presence: true
end

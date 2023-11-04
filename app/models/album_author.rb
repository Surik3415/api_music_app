# frozen_string_literal: true

class AlbumAuthor < ApplicationRecord
  belongs_to :album
  belongs_to :author
end

# frozen_string_literal: true

class SongAuthor < ApplicationRecord
  belongs_to :song
  belongs_to :author
end

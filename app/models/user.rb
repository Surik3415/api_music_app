# frozen_string_literal: true

class User < ApplicationRecord
  include ImageUploader::Attachment(:image)
  include UserValidationsConcern
  has_secure_password
  has_many :playlists
end

# frozen_string_literal: true

class User < ApplicationRecord
  include ImageUploader::Attachment(:image)
  has_secure_password
  include UserValidationsConcern
end

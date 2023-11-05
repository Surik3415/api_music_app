# frozen_string_literal: true

class Genre < ApplicationRecord
  has_many :songs
  has_many :albums

  validates :name, presence: true
end

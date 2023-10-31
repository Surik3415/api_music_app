# frozen_string_literal: true

class Playlist < ApplicationRecord
  belongs_to :user
  enum access_type: { private: 'private', public: 'public', only_friend: 'only_friend' },
       _prefix: true
  enum sharable_type: { closed: 0, open: 1 }

  validates :name, lenght: { in: 3..50 }, presence: true
  validates :description, lenght: { in: 3..250 }
end

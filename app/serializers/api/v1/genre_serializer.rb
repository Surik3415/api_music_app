# frozen_string_literal: true

module Api
  module V1
    class GenreSerializer < ApplicationSerializer
      attribute :genre_name, &:name
    end
  end
end

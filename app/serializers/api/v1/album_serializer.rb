# frozen_string_literal: true

module Api
  module V1
    class AlbumSerializer < ApplicationSerializer
      attribute :album_name, &:name
    end
  end
end

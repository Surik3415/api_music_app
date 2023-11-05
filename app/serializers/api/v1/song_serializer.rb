# frozen_string_literal: true

module Api
  module V1
    class SongSerializer < ApplicationSerializer
      attribute :song_name, &:name
    end
  end
end

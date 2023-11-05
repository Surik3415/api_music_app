# frozen_string_literal: true

module Api
  module V1
    class PlaylistSongSerializer < ApplicationSerializer
      attributes :song_id
      attribute :added_to_playlist_at, &:created_at
    end
  end
end

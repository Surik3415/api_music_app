# frozen_string_literal: true

class CreatePlaylistSongs < ActiveRecord::Migration[7.0]
  def change
    create_table :playlist_songs, id: :uuid do |t|
      t.references :playlist, to_table: :playlists, type: :uuid
      t.references :song, to_table: :songs, type: :uuid

      t.timestamps
    end
  end
end

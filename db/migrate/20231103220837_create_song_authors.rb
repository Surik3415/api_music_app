# frozen_string_literal: true

class CreateSongAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :song_authors, id: :uuid do |t|
      t.references :song, to_table: :songs, type: :uuid
      t.references :author, to_table: :authors, type: :uuid

      t.timestamps
    end
  end
end

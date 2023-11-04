# frozen_string_literal: true

class CreateAlbumAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :album_authors, id: :uuid do |t|
      t.references :album, to_table: :albums, type: :uuid
      t.references :author, to_table: :authors, type: :uuid

      t.timestamps
    end
  end
end

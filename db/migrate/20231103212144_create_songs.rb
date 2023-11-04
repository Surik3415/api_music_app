# frozen_string_literal: true

class CreateSongs < ActiveRecord::Migration[7.0]
  def change
    create_table :songs, id: :uuid do |t|
      t.string :name, null: false
      t.references :album, to_table: :albums, type: :uuid
      t.references :genre, to_table: :genres, type: :uuid

      t.timestamps
    end
    add_index :songs, :name, using: :gin, opclass: :gin_trgm_ops
  end
end

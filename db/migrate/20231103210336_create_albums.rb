# frozen_string_literal: true

class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums, id: :uuid do |t|
      t.string :name
      t.references :genre, to_table: :genres, type: :uuid
      t.jsonb :image_data

      t.timestamps
    end
    add_index :albums, :name, using: :gin, opclass: :gin_trgm_ops
  end
end

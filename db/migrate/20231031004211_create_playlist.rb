# frozen_string_literal: true

class CreatePlaylist < ActiveRecord::Migration[7.0]
  def change
    create_enum :access_type, %w[private public only_friend]
    enable_extension :pg_trgm

    create_table :playlists, id: :uuid do |t|
      t.belongs_to :user, null: false, type: :uuid
      t.string :name, null: false
      t.text :description
      t.jsonb :image_data
      t.integer :likes, default: 0
      t.integer :sharable_type, default: 0
      t.enum :access_type, enum_type: 'access_type', default: 'private', null: false
      t.boolean :featured, default: false

      t.timestamps
    end
    add_index :playlists, :name, using: :gin, opclass: :gin_trgm_ops
  end
end

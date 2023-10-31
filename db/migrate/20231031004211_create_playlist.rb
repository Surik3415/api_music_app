# frozen_string_literal: true

class CreatePlaylist < ActiveRecord::Migration[7.0]
  def change
    create_enum :access_type, %w[private public only_friend]

    create_table :playlists do |t|
      t.belongs_to :user, null: false, type: :uuid
      t.string :name, null: false
      t.text :description
      t.jsonb :logo
      t.integer :likes, default: 0
      t.integer :sharable_type, default: 0
      t.enum :access_type, enum_type: 'access_type', default: 'private', null: false
      t.boolean :featured, default: false

      t.timestamps
    end
  end
end

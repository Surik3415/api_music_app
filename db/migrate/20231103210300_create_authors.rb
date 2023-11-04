# frozen_string_literal: true

class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
    add_index :authors, :name, using: :gin, opclass: :gin_trgm_ops
  end
end

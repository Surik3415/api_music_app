# frozen_string_literal: true

class CreateGenres < ActiveRecord::Migration[7.0]
  def change
    create_table :genres, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class AddImageDataToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :image_data, :jsonb
  end
end

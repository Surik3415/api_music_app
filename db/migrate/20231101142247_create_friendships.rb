# frozen_string_literal: true

class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships do |t|
      t.references :user, to_table: :users, type: :uuid
      t.references :friend, to_table: :users, type: :uuid

      t.timestamps
    end
    add_index :friendships, %i[user_id friend_id]
  end
end

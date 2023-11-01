# frozen_string_literal: true

class CreateFriendRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :friend_requests, id: :uuid do |t|
      t.references :sender, to_table: :users, type: :uuid
      t.references :receiver, to_table: :users, type: :uuid
      t.timestamps
    end

    add_index :friend_requests, %i[sender_id receiver_id], unique: true
  end
end

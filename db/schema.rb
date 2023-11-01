# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_231_101_152_453) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum 'access_type', %w[private public only_friend]

  create_table 'friend_requests', id: :uuid, default: lambda {
                                                        'gen_random_uuid()'
                                                      }, force: :cascade do |t|
    t.uuid 'sender_id'
    t.uuid 'receiver_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['receiver_id'], name: 'index_friend_requests_on_receiver_id'
    t.index %w[sender_id receiver_id],
            name: 'index_friend_requests_on_sender_id_and_receiver_id', unique: true
    t.index ['sender_id'], name: 'index_friend_requests_on_sender_id'
  end

  create_table 'friendships', force: :cascade do |t|
    t.uuid 'user_id'
    t.uuid 'friend_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['friend_id'], name: 'index_friendships_on_friend_id'
    t.index %w[user_id friend_id], name: 'index_friendships_on_user_id_and_friend_id'
    t.index ['user_id'], name: 'index_friendships_on_user_id'
  end

  create_table 'playlists', force: :cascade do |t|
    t.uuid 'user_id', null: false
    t.string 'name', null: false
    t.text 'description'
    t.jsonb 'logo'
    t.integer 'likes', default: 0
    t.integer 'sharable_type', default: 0
    t.enum 'access_type', default: 'private', null: false, enum_type: 'access_type'
    t.boolean 'featured', default: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_playlists_on_user_id'
  end

  create_table 'users', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'username'
    t.string 'password_digest'
    t.string 'email'
    t.jsonb 'image_data'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end

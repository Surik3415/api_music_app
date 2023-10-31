# frozen_string_literal: true

require 'shrine'

if Rails.env.test?
  require 'shrine/storage/memory'
  Shrine.storages = { cache: Shrine::Storage::Memory.new, store: Shrine::Storage::Memory.new }

elsif Rails.env.production?
  require 'shrine/storage/s3'
  s3_options = {
    bucket:            '<YOUR BUCKET>', # required
    access_key_id:     '<YOUR KEY>',
    secret_access_key: '<YOUR SECRET>',
    region:            '<REGION>'
  }

  Shrine.storages = {
    cache: Shrine::Storage::S3.new(prefix: 'cache', **s3_options),
    store: Shrine::Storage::S3.new(**s3_options)
  }
else
  require 'shrine/storage/file_system'
  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'), # temporary
    store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads') # permanent
  }
end

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # enables retaining cached file across form redisplays
Shrine.plugin :restore_cached_data # extracts metadata for assigned cached files
Shrine.plugin :validation_helpers
Shrine.plugin :validation
Shrine.plugin :determine_mime_type

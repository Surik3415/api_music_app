# frozen_string_literal: true

class ImageUploader < Shrine
  # plugins and uploading logic
  plugin :remove_attachment
  plugin :default_url
  plugin :validation

  Attacher.validate do
    validate_size      1..10 * 1024 * 1024
    validate_mime_type %w[image/jpeg image/png image/webp image/tiff]
    validate_extension %w[jpg jpeg png webp tiff tif]
  end

  Attacher.default_url do |**_options|
    "/#{name}/missing.jpg"
  end
end

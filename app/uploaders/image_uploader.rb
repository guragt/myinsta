class ImageUploader < BaseUploader
  version :thumb do
    process resize_to_fill: [614, 614]
  end

  version :small_thumb, from_version: :thumb do
    process resize_to_fill: [300, 300]
  end
end

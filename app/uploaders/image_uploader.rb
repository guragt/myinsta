class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process resize_to_fill: [614, 614]
  end

  version :small_thumb, from_version: :thumb do
    process resize_to_fill: [300, 300]
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end
end

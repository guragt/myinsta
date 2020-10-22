class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*_args)
    ActionController::Base.helpers.asset_path('fallback/' + [version_name, 'default_avatar.png'].compact.join('_'))
  end

  version :thumb do
    process resize_to_fill: [150, 150]
  end

  version :small_thumb, from_version: :thumb do
    process resize_to_fill: [36, 36]
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end
end

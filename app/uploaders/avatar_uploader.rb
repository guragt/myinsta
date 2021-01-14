class AvatarUploader < BaseUploader
  def default_url(*_args)
    ActionController::Base
      .helpers
      .asset_path("fallback/#{[version_name, 'default_avatar.png'].compact.join('_')}")
  end

  version :thumb do
    process resize_to_fill: [150, 150]
  end

  version :small_thumb, from_version: :thumb do
    process resize_to_fill: [36, 36]
  end

  version :medium_thumb, from_version: :thumb do
    process resize_to_fill: [70, 70]
  end
end

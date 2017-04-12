class PictureUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  process :convert => 'png'
  process :tags => ['user_picture']

  version :profile do
    process :resize_to_fill => [256, 256, :north]
  end

  version :thumbnail do
    resize_to_fit(50, 50)
  end

  def public_id
  return model.name
end

end

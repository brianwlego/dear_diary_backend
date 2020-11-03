class Photo < ApplicationRecord
  belongs_to :post

  def save_image(image, photo)
    name = File.basename(image)
    obj = S3_BUCKET.object(name)
    obj.upload_file(image)
    photo.img_url = obj.public_url.to_s
    photo.save
  end


end

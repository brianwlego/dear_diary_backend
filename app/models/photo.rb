class Photo < ApplicationRecord
  belongs_to :post

  has_one_attached :post_photo


end

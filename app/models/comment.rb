class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :comment_likes, :dependent => :delete_all
end

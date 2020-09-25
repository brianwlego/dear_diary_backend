class User < ApplicationRecord
  has_many :posts, :dependent => :delete_all
  has_many :comments, :dependent => :delete_all
  has_many :post_likes, through: :posts, :dependent => :delete_all
  has_many :comment_likes, through: :comments, :dependent => :delete_all

  has_secure_password

  validates :email, uniqueness: true



end

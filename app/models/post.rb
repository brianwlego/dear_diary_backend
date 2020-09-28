class Post < ApplicationRecord
    belongs_to :user
    has_many :post_likes, :dependent => :delete_all
    has_many :users, through: :post_likes
    has_many :comments, :dependent => :delete_all
    has_many :users, through: :comments


end

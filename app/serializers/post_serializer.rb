class PostSerializer < ActiveModel::Serializer
  attributes :id, :content
  has_many :post_likes
  has_many :comments


end
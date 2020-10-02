class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :post_id, :user_id, :user_name, :user_url
  has_many :comment_likes

  def user_name
    object.user.first_name + " " + object.user.last_name
  end

  def user_url
    object.user.img_url
  end

end
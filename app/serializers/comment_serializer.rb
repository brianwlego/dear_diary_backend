class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :post_id, :user_id
  has_many :comment_likes

  def user_name
    object.user.first_name + " " + object.user.last_name
  end

end
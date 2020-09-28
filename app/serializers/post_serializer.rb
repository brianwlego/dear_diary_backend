class PostSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_name, :post_likes, :comments, :user_id, :created_at, :updated_at

  def user_name
    object.user.first_name + " " + object.user.last_name
  end

  def post_likes
    object.post_likes.map { |like| {id: like.id, post_id: like.post_id, user_id: like.user_id }}
  end

  def comments 
    object.comments.map {|comment| CommentSerializer.new(comment)}
  end

end
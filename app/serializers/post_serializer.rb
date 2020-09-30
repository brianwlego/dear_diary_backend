class PostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :content, :user_name, :post_likes, :comments, :user_id, :profile_user_id, :time, :post_user_url

  def user_name
    object.user.first_name + " " + object.user.last_name
  end

  def post_likes
    object.post_likes.map { |like| {id: like.id, post_id: like.post_id, user_id: like.user_id }}
  end

  def comments 
    object.comments.map {|comment| CommentSerializer.new(comment)}
  end

  def time
    object.determine_time
  end

  def post_user_url
    if object.user.profile_picture.attached? == true 
      rails_blob_url(object.user.profile_picture, only_path: true)
    else
      ""
    end
  end
end
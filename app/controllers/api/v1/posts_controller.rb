class Api::V1::PostsController < ApplicationController

  def show
    post = Post.find(params[:id])
    render json: PostSerializer.new(post), status: :accepted
  end

  def create
    post = Post.create(content: post_params[:content], user_id: current_user.id)
    if post.valid?
      render json: post, status: :accepted
    else 
      render json: { error: 'Failed to create post' }, status: :not_acceptable
    end
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    if post.valid?
      render json: {post: PostSerializer.new(post)}, status: :accepted
    else
      render json: { error: 'Failed to update post' }, status: :not_acceptable
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    if !post.save
      render json: {}, status: :accepted
    else
      render json: {error: 'Failed to delete post', post: post}, status: :not_acceptable
    end
  end


  def like
    new_like = PostLike.create(post_like_params)
    post = Post.find(new_like.post_id)
    if new_like.valid?
      render json: post, include: [:likes, :comments], status: :accepted
    else
      render json: {error: "Failed to like post"}, status: :not_acceptable
    end
  end 

  def unlike
    like = CommentLike.find(params[:id])
    like.destroy
    if !like.id
      render json: {success: "Like deleted"}, status: :accepted
    else
      render json: {error: "Failed to delete like"}, status: :not_acceptable
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def post_like_params
    params.require(:post_like).permit(:user_id, :post_id)
  end

end
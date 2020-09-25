class Api::V1::CommentsController < ApplicationController

  def create
    comment = Comment.create(comment_params)
    post = Post.find(comment_params[:post_id])
    if comment.valid?
      render json: { post: PostSerializer.new(post) }, status: :accepted
    else 
      render json: { error: 'Failed to create comment' }, status: :not_acceptable
    end
  end

  def update
    comment = Comment.find(params[:id])
    comment.update(comment_params)
    post = Post.find(comment.post_id)
    if comment.valid?
      render json: { post: PostSerializer.new(post) }, status: :accepted
    else 
      render json: { error: 'Failed to update comment' }, status: :not_acceptable
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    post = Post.find(comment.post_id)
    if !comment.save 
      render json: { post: PostSerializer.new(post) }, status: :accepted
    else
      render json: {error: 'Failed to delete comment', comment: comment}, status: :not_acceptable
    end
  end

  def like
    new_like = CommentLike.create(comment_like_params)
    comment = Comment.find(new_like.comment_id)
    if new_like.valid?
      render json: { comment: CommentSerializer.new(comment) }, status: :accepted
    else
      render json: {error: "Failed to like comment", comment: comment }, status: :not_acceptable
    end
  end 

  def unlike
    like = CommentLike.find(params[:id])
    comment = Comment.find(like.comment_id)
    like.destroy
    if !like.save
      render json: { comment: CommentSerializer.new(comment) }, status: :accepted
    else
      render json: {error: "Failed to delete like"}, status: :not_acceptable
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end

  def comment_like_params
    params.require(:comment_like).permit(:user_id, :comment_id)
  end

end
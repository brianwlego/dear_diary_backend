class Api::V1::PostsController < ApplicationController

  def create
    comment = Comment.create(comment_params)
    if comment.valid?
      render json: comment, status: :accepted
    else 
      render json: { error: 'Failed to create comment' }, status: :not_acceptable
    end
  end

  def update
    comment = comment.update(comment_params)
    if comment.valid?
      render json: comment, include: [:likes], status: :accepted
    else 
      render json: { error: 'Failed to update comment' }, status: :not_acceptable
    end
  end

  def delete
    comment = Comment.find(params[:id])
    comment.destroy
    if !comment.id 
      render json: {}, status: :accepted
    else
      render json: {error: 'Failed to delete comment', comment: comment}, status: :not_acceptable
    end
  end

  def like
    new_like = CommentLike.create(comment_like_params)
    comment = Comment.find(new_like.comment_id)
    if new_like.valid?
      render json: comment, include: [:likes], status: :accepted
    else
      render json: {error: "Failed to like comment", comment: comment include: [:likes]}, status: :not_acceptable
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

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end

  def comment_like_params
    params.require(:comment_like).permit(:user_id, :comment_id)
  end

end
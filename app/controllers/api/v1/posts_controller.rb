class Api::V1::PostsController < ApplicationController

  def show
    post = Post.find(params[:id])
    render json: { post: PostSerializer.new(post) }, status: :accepted
  end


  def create
    # VALIDATION TO CHECK CURRENT USER AGAINST POST USER FROM FRONT END
    post = Post.create(post_params)
   
    # SENDING BACK EITHER CREATED POST OR FAILED ERROR
    if post.valid?
      render json: {post: PostSerializer.new(post) } , status: :accepted
    else 
      render json: { error: 'Failed to create post' }, status: :not_acceptable
    end
  end

  def update
    # VALIDATION TO CHECK CURRENT USER AGAINST POST USER FROM FRONT END
    if current_user.id === post_params[:user_id]
      post = Post.find(params[:id])
      post.update(post_params)
    end
    # SENDING BACK EITHER CREATED POST OR FAILED ERROR
    if post.valid?
      render json: {post: PostSerializer.new(post)}, status: :accepted
    else
      render json: { error: 'Failed to update post' }, status: :not_acceptable
    end
  end

  def destroy
    # VALIDATION TO CHECK CURRENT USER AGAINST POST USER FROM FRONT END
    if current_user.id === post_params[:user_id]
      post = Post.find(params[:id])
      post.destroy
    end
    # SENDING BACK EITHER CREATED POST OR FAILED ERROR
    if !post.save
      render json: {}, status: :accepted
    else
      render json: {error: 'Failed to delete post', post: post}, status: :not_acceptable
    end
  end

####### METHODS TO EITHER LIKE OR UNLIKE A POST ########

  def like
    found = PostLike.find_by(user_id: current_user.id, post_id: post_like_params[:post_id])
    if found 
        render json: { error: "Failed to like post, post has already been liked by this user." }
    else
      if current_user.id === post_like_params[:user_id]
        new_like = PostLike.create(post_like_params)
      end
      post = Post.find(params[:post_id])
      if new_like.valid?
        render json: {post: PostSerializer.new(post)}, status: :accepted
      else
        render json: {error: "Failed to like post"}, status: :not_acceptable
      end
    end


  end 

  def unlike
    like = PostLike.find(params[:id])
    like.destroy
    post = Post.find(params[:post_id])
    if !like.save
      render json: {post: PostSerializer.new(post)}, status: :accepted
    else
      render json: {error: "Failed to delete like"}, status: :not_acceptable
    end
  end



  private



  def post_params
    params.require(:post).permit(:content, :user_id, :profile_user_id)
  end

  def post_like_params
    params.require(:post_like).permit(:user_id, :post_id)
  end

end
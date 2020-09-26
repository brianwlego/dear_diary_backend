class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def profile
    render json: { user: UserSerializer.new(current_user) }, status: :accepted
  end

  def show
    user = User.find(params[:id])
    render json: { user: UserSerializer.new(user) }, stats: :accepted
  end

  def create
    user = User.create(user_params)
    if user.valid?
      token = encode_token({ user_id: user.id })
      render json: { user: UserSerializer.new(user), jwt: token }, status: :created
    else
      render json: { error: 'failed to create user' }, status: :not_acceptable
    end
  end

  def follow
    follow = Follow.create(follow_params)
    user = User.find(follow_params[:followed_user_id])
    if follow.valid?
      render json: { user: UserSerializer.new(user)}, status: :accepted
    else
      render json: { error: "Failed to follow user" }, status: :not_acceptable
    end
  end

  def unfollow
    follow = Follow.find_by(follower_id: follow_params[:follower_id], followed_user_id: follow_params[:followed_user_id])
    user = User.find(follow_params[:followed_user_id])
    follow.destroy 
    if !follow.save
      render json: { user: UserSerializer.new(user) }, status: :accepted
    else
      render json: { error: "Failed to unfollow user" }, status: :not_acceptable
    end
  end

  def followers
    user = User.find(params[:user_id])
    render json: { followers: UserSerializer.new(user).followers }, status: :accepted
  end

  def followings
    user = User.find(params[:user_id])
    render json: { followers: UserSerializer.new(user).followings }, status: :accepted
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :birthdate, :img_url)
  end

  def follow_params
    params.require(:follow).permit(:follower_id, :followed_user_id )
  end

end
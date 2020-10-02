class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def profile1
    render json: { user: UserSerializer.new(current_user) }, status: :accepted
  end

  def index
    users = User.all
    render json: users
  end

  def home
    user = User.find(params[:user_id])
    posts = user.filter_home_posts
    render json: { posts: posts}, stats: :accepted
  end

  def show
    user = User.find(params[:id])
    render json: { user: UserSerializer.new(user) }, stats: :accepted
  end

  def profile2
    posts = Post.where(profile_user_id: params[:user_id].to_i)
    newArray = posts.map{ |post| PostSerializer.new(post) }
    user = User.find(params[:user_id])
    u = UserSerializer.new(user)
    render json: { user: u, posts: newArray }, stats: :accepted
  end

  def create
    user = User.create(user_params)
    if params[:profile_picture] != ''
      user.profile_picture.attach(params[:profile_picture])
      user.img_url = url_for(user.profile_picture)
      user.save
    end
    if user.valid?
      token = encode_token({ user_id: user.id })
      render json: { user: UserSerializer.new(user), jwt: token }, status: :created
    else
      render json: { error: 'failed to create user' }, status: :not_acceptable
    end
  end

  def update
    if current_user.id === params[:id].to_i
      user = User.find(params[:id])
      user.update(user_params)
    end
    if user.valid?
      render json: { user: UserSerializer.new(user) }, status: :accepted
    else
      render json: { error: "Failed to update User"}, statu: :not_acceptable
    end
  end

  def follow
    found = Follow.find_by(follower_id: current_user.id, followed_user_id: follow_params[:followed_user_id])
    if found 
        render json: { error: "Failed to like post, post has already been liked by this user." }
    else
      follow = Follow.create(follow_params)
      if follow.valid?
        render json: { success: "New follow created"}, status: :accepted
      else
        render json: { error: "Failed to follow user" }, status: :not_acceptable
      end
    end
  end

  def unfollow
    follow = Follow.find_by(follower_id: follow_params[:follower_id], followed_user_id: follow_params[:followed_user_id])
    user = User.find(follow_params[:followed_user_id])
    follow.destroy 
    if !follow.save
      render json: { success: "Follow was deleted" }, status: :accepted
    else
      render json: { error: "Failed to unfollow user" }, status: :not_acceptable
    end
  end

  def followers
    user = User.find(params[:user_id])
    render json: { followers: UserSerializer.new(user).followers }, status: :accepted
  end

  def followings
    # byebug
    user = User.find(params[:user_id])
    render json: { followers: UserSerializer.new(user).followings }, status: :accepted
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :birthdate, :bio, :work, :location)
  end

  def follow_params
    params.require(:follow).permit(:follower_id, :followed_user_id )
  end

end
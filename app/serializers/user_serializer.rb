class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :user_name, :img_url, :birthday, :profile_friends
  # has_many :posts


  def user_name
    object.first_name + " " + object.last_name
  end
  def birthday
    object.birthday_readable
  end

  def profile_friends
    object.followers.map { |user| {user_name: user.first_name + " " + user.last_name, img_url: user.img_url, id: user.id}}
  end

  def followers
    object.followers.map{ |user| UserSerializer.new(user) }
  end

  def followings
    object.followings.map { |user| UserSerializer.new(user) }
  end

end

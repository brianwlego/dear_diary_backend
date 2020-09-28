class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :birthdate, :img_url, :user_name
  has_many :posts


  def user_name
    object.first_name + " " + object.last_name
  end

  def followers
    object.followers.map{ |user| UserSerializer.new(user) }
  end

  def followings
    object.followings.map { |user| UserSerializer.new(user) }
  end

end

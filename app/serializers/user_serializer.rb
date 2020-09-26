class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :birthdate, :img_url
  has_many :posts


  def followers
    object.followers.map{ |user| UserSerializer.new(user) }
  end

  def followings
    object.followings.map { |user| UserSerializer.new(user) }
  end

end

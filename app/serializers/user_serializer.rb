class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :first_name, :last_name, :email, :user_name, :pic_url, :birthday
  has_many :posts


  def user_name
    object.first_name + " " + object.last_name
  end

  def pic_url
    if object.profile_picture.attached? == true 
      rails_blob_url(object.profile_picture, only_path: true)
    else
      ""
    end
  end

  def birthday
    object.birthday_readable
  end

  def followers
    object.followers.map{ |user| UserSerializer.new(user) }
  end

  def followings
    object.followings.map { |user| UserSerializer.new(user) }
  end

end

class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :birthdate, :img_url
  has_many :posts

end

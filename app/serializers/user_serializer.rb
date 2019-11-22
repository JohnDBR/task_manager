# This serializer shows the important elements for the user entity and other enttities related
class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :middlename, :lastname, :image_url,
             :birthdate, :gender, :email, :password_digest, :role, :created_at, :updated_at

  def image_url
    object.image_url
  end
end

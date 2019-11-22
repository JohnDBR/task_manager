# This serializer shows all the elements of a token entity and some important information to be stored
class LoginSerializer < ActiveModel::Serializer
  attributes :id, :secret, :expire_at, :user, :created_at, :updated_at

  def user
    UserSerializer.new(object.user)
  end
end

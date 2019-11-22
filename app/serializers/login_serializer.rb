# This serializer shows all the elements of a token entity and some important information to be stored
class LoginSerializer < ActiveModel::Serializer
  attributes :id, :secret, :expire_at, :created_at, :updated_at

  belongs_to :user
  # def user
  #   UserSerializer.new(object.user)
  # end
end

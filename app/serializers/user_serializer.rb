# This serializer shows the important elements for the user entity and other enttities related
class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :middlename, :lastname, :image_url, :birthdate, :gender, :email,
             :role, :user_supervisor, :users_supervised, :tasks, :created_at, :updated_at

  def tasks
    Task.serialize(object.tasks)
  end

  def image_url
    object.image_url
  end

  def user_supervisor
    UserSerializer.new(object.user_supervisor.first) if object.supervised?
  end

  def users_supervised
    UserSupervisor.serialize(object.users_supervised) if object.users_supervised.empty?
  end
end

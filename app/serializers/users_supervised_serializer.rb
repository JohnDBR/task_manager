class UsersSupervisedSerializer < ActiveModel::Serializer
  attributes :id, :name, :middlename, :lastname, :image_url, :birthdate, :gender, :email,
             :role, :user_supervisor, :users_supervised, :tasks, :created_at, :updated_at

  def tasks
    Task.serialize(object.tasks)
  end

  def image_url
    object.image_url
  end
end

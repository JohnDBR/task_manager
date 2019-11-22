# This serializer shows the important elements for the task entity and other enttities related
class TasksSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :start_time, :end_time, :high_priority, :category, :completed, :expired,
             :created_at, :updated_at

  def expired
    object.expired?
  end
end

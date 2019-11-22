# == Schema Information
#
# table name: tasks
#
# t.string :name
# t.string :description
# t.datetime :start_time
# t.datetime :end_time
# t.boolean :high_priority, default: false
# t.boolean :completed, default: false
# t.integer :category, default: 0
# t.integer :user_id

class Task < ApplicationRecord
  # Validations
  validates :name, :description, :start_time, :end_time, :category, presence: true, on: :create

  # Callbacks
  # Relations
  belongs_to :user

  # Attributes
  def expired?
    end_time.past? && !completed
  end

  def completed?
    completed
  end

  def on_task?
    start_time.past? && !end_time.past?
  end

  # Actions
  def self.serialize(collection)
    ActiveModel::Serializer::CollectionSerializer.new(collection, serializer: TasksSerializer)
  end
end

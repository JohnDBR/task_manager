class UserSupervisor < ApplicationRecord
  # Validations
  validates :user_id, uniqueness: true

  # Callbacks
  # Relations
  belongs_to :supervisor, class_name: 'User', foreign_key: :supervisor_id
  belongs_to :supervised, class_name: 'User', foreign_key: :user_id

  # Attributes
  # Actions
  def self.serialize(collection)
    { users_supervised: ActiveModel::Serializer::CollectionSerializer.new(collection, serializer: UserSerializer) }
  end
end

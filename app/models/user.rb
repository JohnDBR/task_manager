# == Schema Information
#
# table name: users
#
# t.string :name
# t.string :middlename
# t.string :lastname
# t.date :birthdate
# t.integer :gender
# t.string :email
# t.string :password_digest
# t.integer :role
# t.timestamps

class User < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_secure_password

  # Validations
  validates :name, presence: true, on: :account_setup # :middlename, :lastname, :birthdate, :gender
  validates :email, :password, :role, presence: true, on: :account_setup
  validates :image, blob: {
    content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 0..5.megabytes
  }, on: :account_setup
  validates :email, uniqueness: true, on: :account_setup

  validates :name, presence: true, on: :account_update # :middlename, :lastname, :birthdate, :gender
  validates :email, :password, :role, presence: true, on: :account_update
  validates :image, blob: {
    content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 0..5.megabytes
  }, on: :account_update
  validates :email, uniqueness: true, on: :account_update

  validates :password, presence: true, on: :forgot_password

  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :password, length: { minimum: 6 }, on: %i[forgot_password account_setup]

  # Callbacks
  before_validation :format_downcase
  after_destroy :delete_image

  # Relations
  has_one_attached :image
  has_many :tokens, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :user_supervisors
  # has_many :users_supervised, through: :user_supervisors, source: :supervised
  has_many :user_supervisor, through: :user_supervisors, source: :supervisor

  # has_many :users_supervised, through: :user_supervisors, class_name: 'User', source: :supervised
  # has_many :user_supervisor, class_name: 'User', foreign_key: :supervisor_id, through: :user_supervisors, source: :supervisor #, through: :user_supervisors, source: supervisor

  # Attributes
  def user?
    role&.eql? 'user'
  end

  def supervisor?
    role&.eql? 'supervisor'
  end

  def admin?
    role&.eql? 'admin'
  end

  def image_url
    url_for(image) if image.attached?
    # Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)
  end

  def supervised?
    !user_supervisor.empty?
  end

  def supervised_by?(user)
    user_supervisor.id == user.id
  end

  def supervising_on?(user)
    users_supervised.include? user
  end

  def users_supervised
    u = user_supervisors.where(supervisor_id: id)
    pp u 
    u
  end

  # Actions
  def create_token
    Token.new(user_id: id)
  end

  def delete_image
    image.purge_later if image.attached?
  end

  protected

  def format_downcase
    name&.downcase!
    middlename&.downcase!
    lastname&.downcase!
    email&.downcase!
  end
end

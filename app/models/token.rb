# == Schema Information
#
# table name: tokens
#
# t.string :secret
# t.date :expire_at
# t.integer :user_id
# t.timestamps

class Token < ApplicationRecord
  # Validations
  validates :secret, :expire_at, presence: true
  validates :secret, uniqueness: true

  # Callbacks
  before_validation :set_secret, on: :create
  before_validation :set_expire_at, on: :create

  # Relations
  belongs_to :user

  # Attributes
  def expired?
    expire_at.past?
  end

  # Actions
  protected

  def set_secret
    loop do
      self.secret = SecureRandom.uuid.gsub(/-/, '')
      break if Token.where(secret: secret).empty?
    end
  end

  def set_expire_at
    self.expire_at = 1.week.from_now
  end
end

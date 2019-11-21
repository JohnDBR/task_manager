class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Record types
  enum role: %i[user supervisor admin]

  # User Account
  enum gender: %i[male female other]

  # -- All models should follow the same order instruction:
  # Gems actions
  # Validations
  # Callbacks
  # Relations
  # Attributes
  # Actions
end

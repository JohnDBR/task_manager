class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  enum role: %i[user supervisor admin]
  enum gender: %i[male female other]
  enum category: %i[health sport art freelance meetings education]

  # -- All models should follow the same order instruction:
  # Gems actions
  # Validations
  # Callbacks
  # Relations
  # Attributes
  # Actions
end

# This service helps the session controller to verify the user credentials!
class Authentication
  attr_accessor :user, :errors

  def initialize
    @user = nil
    @errors = {}
    @allowed = true
  end

  def start_session(credentials, user)
    single_login(credentials, user)
  end

  def allowed?
    @allowed
  end

  private

  def single_login(credentials, user)
    @user = user
    # Validate that the credentials match!
    return if @user&.authenticate(credentials[:password])

    @allowed = false
    @errors[:error] = 'invalid credentials'
  end
end

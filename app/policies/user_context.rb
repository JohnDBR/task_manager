# This class is the context of the pundit user according to the docs
class UserContext
  attr_reader :user, :params

  def initialize(user, params)
    @user = user
    @params = params
  end
end

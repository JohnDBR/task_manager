# This controller has all the authentication enpoints!
class Users::SessionsController < ApplicationController
  skip_before_action :set_current_user, only: [:create]
  before_action :set_user, only: [:create]

  # POST /sessions
  def create
    auth = Authentication.new
    auth.start_session(session_params, @user)
    if auth.allowed?
      render_login_serializer
    else
      render_unauthorized auth.errors
    end
  end

  # DELETE /sessions
  def destroy
    render_ok @token.destroy
  end

  private

  def render_login_serializer
    token = @user.create_token
    if token.save
      render_created LoginSerializer.new(token).as_json
    else
      render_unprocessable_entity token.errors.messages
    end
  end

  def set_user
    @user = User.find_by(email: params[:email]&.downcase)
  end

  def session_params
    params.permit(:email, :username, :password, :verify_email_token)
  end
end

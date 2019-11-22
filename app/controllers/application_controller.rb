class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception
  skip_before_action :verify_authenticity_token

  include Pundit
  include ActionController::HttpAuthentication::Token::ControllerMethods

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from Pundit::NotAuthorizedError, with: :if_current_user_is_not_allowed
  rescue_from Exceptions::TokenExpired, with: :if_token_expired
  rescue_from Exceptions::NoContentToShow, with: :if_no_content

  before_action :set_current_user

  # To use it - {Rails.application.config.action_controller.default_url_options[:host]}
  def self.default_url_options
    if Rails.env.production?
      {
        env: 'prod',
        host: ENV['TM_PROD_HOST'],
        protocol: ENV['TM_PROD_PROTOCOL'],
        front_url: ENV['TM_PROD_FRONT_URL'],
        admin_url: ENV['TM_PROD_ADMIN_URL']
      }
    elsif Rails.env.test?
      {
        env: 'test',
        host: ENV['TM_TEST_HOST'],
        protocol: ENV['TM_TEST_PROTOCOL'],
        front_url: ENV['TM_TEST_FRONT_URL'],
        admin_url: ENV['TM_TEST_ADMIN_URL']
      }
    else
      {
        env: 'dev',
        host: ENV['TM_DEV_HOST'],
        protocol: ENV['TM_DEV_PROTOCOL'],
        front_url: ENV['TM_DEV_FRONT_URL'],
        admin_url: ENV['TM_DEV_ADMIN_URL']
      }
    end
  end

  protected

  def set_current_user
    @current_user = nil
    @token = nil
    authenticate_with_http_token do |key, _options|
      # Raise exception if the token isn't found or it isn't provided!
      @token = Token.find_by(secret: key)
      raise ActiveRecord::RecordNotFound, 'token not found' if @token.nil?

      # Raise exception if the token is expired!
      if @token.expired?
        @token.destroy
        raise Exceptions::TokenExpired
      end

      @current_user = @token&.user
    end
    # Raise exception if there the authorization token wasn't found
    raise ActiveRecord::RecordNotFound, 'token not found' if @token.nil?
  end

  def pundit_user
    UserContext.new(@current_user, params)
  end

  def policy(record)
    policies[record] ||= "#{controller_path.classify}Policy".constantize.new(pundit_user, record)
  end

  def nil_protection(obj)
    begin
      # Raise exception if there is no content to show for obj type array
      raise Exceptions::NoContentToShow if obj&.empty?
    rescue NoMethodError
      # Raise exception if there is no content to show for obj type object (one element)
      raise Exceptions::NoContentToShow if obj&.nil?
    end
    obj
  end

  # Status 200 - Standard response!
  def render_ok(obj)
    render json: nil_protection(obj), status: :ok
  end

  # Status 201 - New resource created!
  def render_created(obj)
    render json: nil_protection(obj), status: :created
  end

  # Status 401 - Invalid credentials, authentication fails!
  def render_unauthorized(obj)
    render json: nil_protection(obj), status: :unauthorized
  end

  # Status 403 - You don't have permissions!
  def render_forbidden(obj)
    render json: nil_protection(obj), status: :forbidden
  end

  # Status 422 - Request is well formed but has semantic errors!
  def render_unprocessable_entity(obj)
    render json: nil_protection(obj), status: :unprocessable_entity
  end

  # HANDLE EXCEPTIONS!

  def record_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def if_token_expired
    render json: { error: 'token has expired' }, status: :unprocessable_entity
  end

  def if_current_user_is_not_allowed
    render json: { error: 'user not allowed to perform the action' }, status: :forbidden
  end

  def if_no_content
    render json:
    {
      message: 'The server successfully processed the request, but there is no content to return'
    }, status: :ok
  end
end

# This controller has all the users endpoints!
class UsersController < ApplicationController
  skip_before_action :set_current_user, only: [:create]
  before_action :set_user, only: %i[show update destroy]

  # GET /users
  def index
    authorize User
    users = User.all
    render_ok users
  end

  # GET /users/:user_id
  def show
    authorize @user
    render_ok @user
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save(context: :account_setup)
      render_created @user
    else
      render_unprocessable_entity @user.errors.messages
    end
  end

  # PUT /users/:user_id
  def update
    authorize @user
    @user.assign_attributes(user_params)
    if @user.save(context: :account_update)
      render_ok @user
    else
      render_unprocessable_entity @user.errors.messages
    end
  end

  # DELETE /users/:user_id
  def destroy
    authorize @user
    render_ok @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:name, :middlename, :lastname, :birthdate, :gender, :email, :password, :image)
  end
end

# This controller has all the supervisor endpoints!
class SupervisorsController < ApplicationController
  before_action :set_user_by_email, only: %i[create]

  # GET /users/:user_id/users_supervised
  def index
    authorize @user
    users_supervised = @user.users_supervised
    render_ok users_supervised
  end

  # POST /users/:user_id/supervisor
  def create
    authorize @user
    us = UserSupervisor.new(user_id: @user.id, supervisor_id: @current_user.id)
    if us.save
      render_created us
    else
      render_unprocessable_entity us.errors
    end
  end

  # DELETE /user_supervised/:id
  def destroy
    authorize @us
    render_ok @us.destroy
  end

  private

  def set_user_by_email
    @user = User.find_by(email: params[:email])
  end

  def set_user_supervised
    @user_supervised = UserSupervisor.find(params[:id])
  end
end

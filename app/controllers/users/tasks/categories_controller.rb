# This controller has all the tasks endpoints of an user that relates to a category!
class Users::Tasks::CategoriesController < ApplicationController
  before_action :set_user, only: %i[index]

  # GET /users/:user_id/categories/:category/tasks
  def index
    authorize @user
    tasks = @user.tasks.where(category: params[:category])
    render_ok tasks
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end

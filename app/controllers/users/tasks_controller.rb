# This controller has all the tasks endpoints!
class Users::TasksController < ApplicationController
  before_action :set_user, only: %i[index create]
  before_action :set_task, only: %i[show update destroy]

  # GET /users/:user_id/tasks
  def index
    authorize @user
    tasks = @user.tasks
    render_ok tasks
  end

  # GET /users/tasks/:id
  def show
    authorize @task
    render_ok @task
  end

  # POST /users/:user_id/tasks
  def create
    authorize @user
    @task = Task.new(task_params)
    if @task.save
      render_created @task
    else
      render_unprocessable_entity @task.errors
    end
  end

  # PUT /tasks/:id
  def update
    authorize @user
    @task.assign_attributes(task_params)
    if @task.save
      render_ok @task
    else
      render_unprocessable_entity @task.errors
    end
  end

  # DESTROY /tasks/:id
  def destroy
    authorize @user
    render_ok @task.destroy
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def task_params
    params.permit(:name, :description, :start_time, :end_time, :high_priority, :category, :completed)
  end
end

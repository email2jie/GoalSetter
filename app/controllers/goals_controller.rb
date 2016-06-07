class GoalsController < ApplicationController
  before_filter :require_login
  def index
    @goals = Goal.where(kind: 'public') + current_user.goals.where(kind: 'private')
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash[:errors] = @goal.errors.full_messages
      redirect_to new_goal_url
    end
  end

  def edit
    @goal = Goal.find(params[:id])
    if @goal.user_id != current_user.id
      flash[:errors] = ["Can't Edit Goals Not Belonging To You!"]
      redirect_to goals_url
    else
      render :edit
    end
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update_attributes(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to goals_url
  end

  def show
    @goal = Goal.find(params[:id])
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :description, :completion, :kind, :status)
  end
end

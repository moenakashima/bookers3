class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @group_users = @group.group_users
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.create
    redirect_to groups_path
  end

  def edit
    @group = Group.find(params[:id])
    redirect_to groups_path unless current_user.id == @group.owner_id
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
    redirect_to groups_path, notice: "You have updated group successfully."
    else
    render :edit
    end

  end

  def destroy

  end

private
  def group_params
    params.require(:group).permit(:name, :introduction)
  end
end

class GroupsController < ApplicationController


  def new
    @group = Group.new
  end

  def index
    @groups = Group.all
    @book = Book.new
  end

  def show
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path, notice: "You have created group successfully."
    else
      render 'new'
    end
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

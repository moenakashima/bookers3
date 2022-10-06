class UsersController < ApplicationController
  def index
    @book = Book.new
    @users = User.all

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user), notice: "You have updated user successfully."

  end

  def show
    @user = User.find(params[:id])
    @books = @user.books


  end
end


  private
  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end
class UsersController < ApplicationController
  def index
    @book = Book.new
    @users = User.all

  end

  def edit
    @user = User.find(params[:id])
    redirect_to user_path(current_user.id) unless current_user.id == @user.id
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end

end

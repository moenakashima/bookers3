class BooksController < ApplicationController
  def index
    @user = current_user
  end 
  
  def show
  end

  def edit
  end
end

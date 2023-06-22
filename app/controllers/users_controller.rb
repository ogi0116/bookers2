class UsersController < ApplicationController
before_action :is_matching_login_user, only: [:edit]



  def index
    @users = User.all
    @user = current_user
    @book = Book.new

  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    #redirect_to edit_pathにするとリダイレクトループになってバグ
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
       flash[:notice] = "User was successfully updated."
       redirect_to user_path(@user)
    else
      render :edit
    end
  end



  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

end

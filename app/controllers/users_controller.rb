class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @users = User.all
  end

  def show
    @user =User.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user), alert: "Invalid access detected"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Update Your Profile successfully"
    else
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:notice] = "User deleted"
    redirect_to users_path
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.all
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.all
    render 'show_follow'
  end

  private
    def user_params
      params.require(:user).permit(:username, :email,:fullname,:phonenumber, :gender, :introduce, :website, :profile_image)
    end
end

class UsersController < ApplicationController


  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    # post_params = params.require(:post).permit(:title, :body)
    if @user.update user_params
      redirect_to root_path, notice: "post updated"
    else
      render :edit
    end
  end

  def edit_password
    @user = User.find params[:id]
    user = User.find_by_email(current_user.email).try(:authenticate, params[:current_password])
    if user && @user.update_attributes(params[:user])
      flash[:success] = "profile updated"
      redirect_to root_path
    else
      flash.now[:error] = "incorrext current password"
      render :edit
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end

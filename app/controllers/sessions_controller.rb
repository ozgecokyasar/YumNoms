class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "thank you for signing in!"
    else
      flash.now[:alert] = "wrong email or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "logged out!"
  end
  private
def session_params
  params.require(:session).permit(:email, :password)
end
end

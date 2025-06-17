class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "Welcome back #{user.name}!"
    else
      render :new, status: :unprocessable_entity, alert: "Invalid email or password."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to movies_path, status: :see_other, notice: "You have been logged out."
  end
end

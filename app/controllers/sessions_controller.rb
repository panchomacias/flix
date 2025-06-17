class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to (session[:intended_url] || user), notice: "Welcome back #{user.name}!"
      session[:intended_url] = nil
    else
      render :new, status: :unprocessable_entity, alert: "Invalid email or password."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to movies_path, status: :see_other, notice: "You have been logged out."
  end
end

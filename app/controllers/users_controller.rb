class UsersController < ApplicationController
  before_action :require_signin, except: [ :new, :create ]
  before_action :require_correct_user, only: [ :edit, :update, :destroy ]
  before_action :require_admin, only: [ :destroy ]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.order(created_at: :desc)
    @grouped_reviews = @reviews.includes(:movie).group_by(&:movie)
    @favorite_movies = @user.favorite_movies
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to users_path, notice: "User was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, status: :see_other, notice: "Account was successfully deleted."
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def require_correct_user
    @user = User.find(params[:id])
    redirect_to movies_path unless current_user?(@user)
  end
end

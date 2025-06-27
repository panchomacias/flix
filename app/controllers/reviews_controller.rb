class ReviewsController < ApplicationController
  before_action :require_signin

  def index
    @movie = Movie.friendly.find(params[:movie_id])
    @reviews = @movie.reviews.all
  end

  def new
    @movie = Movie.friendly.find(params[:movie_id])
    @review = @movie.reviews.new
  end

  def create
    @movie = Movie.friendly.find(params[:movie_id])
    @review = @movie.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to movie_path(@movie), notice: "Review successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @movie = Movie.find(params[:movie_id])
    @review = @movie.reviews.find(params[:id])
  end

  private

  def review_params
    params.require(:review).permit(:comment, :stars)
  end
end

class MoviesController < ApplicationController
  before_action :require_signin, except: [ :index, :show ]
  before_action :require_admin, except: [ :index, :show ]

  def index
    case params[:filter]
    when "upcoming"
      @movies = Movie.upcoming
      @current_filter = "Upcoming"
    when "recent"
      @movies = Movie.recent
      @current_filter = "Recent"
    else
      @movies = Movie.released
      @current_filter = "Released"
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @reviews = @movie.reviews.order("created_at DESC")
    @fans = @movie.fans.distinct
    @genres = @movie.genres.order(:name)
    if current_user
      @favorite = current_user.favorites.find_by(movie_id: @movie.id)
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to movie_path(@movie), notice: "Movie was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movie_path(@movie), notice: "Movie was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path, status: :see_other, notice: "Movie was successfully deleted."
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :description, :released_on, :rating, :total_gross, :director, :duration, :image_file_name, genre_ids: [])
  end
end

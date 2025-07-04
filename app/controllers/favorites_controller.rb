class FavoritesController < ApplicationController
  before_action :require_signin

  def create
    @movie = Movie.find(params[:movie_id])
    @movie.favorites.create!(user: current_user)
    redirect_to movie_path(@movie)
  end

  def destroy
    favorite = current_user.favorites.find(params[:id])
    favorite.destroy

    movie = Movie.find(params[:movie_id])
    redirect_to movie_path(movie), notice: "#{movie.title} is no longer a favorite."
  end
end

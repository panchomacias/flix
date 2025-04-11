require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe "it should have valid attributes" do
    it "should be valid with a title" do
      movie = Movie.new(title: "Inception")
      expect(movie.title).to eq("Inception")
      expect(movie).to be_valid
    end

    it "should be valid with a description" do
      movie = Movie.new(description: "A mind-bending thriller")
      expect(movie.description).to eq("A mind-bending thriller")
      expect(movie).to be_valid
    end

    it "should be valid with a release date" do
      movie = Movie.new(released_on: (Date.today))
      expect(movie.released_on).to eq(Date.today)
      expect(movie).to be_valid
    end

    it "should be valid with a rating" do
      movie = Movie.new(rating: "PG-13")
      expect(movie.rating).to eq("PG-13")
      expect(movie).to be_valid
    end
  end
end

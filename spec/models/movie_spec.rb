require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe "is should be invalid without correct validations" do
    before do
      @movie = Movie.new(title: nil, description: nil, released_on: nil, rating: nil, total_gross: -1, duration: nil, image_file_name: "test.txt")
    end

    it "should be invalid without a title" do
      expect(@movie).not_to be_valid
      expect(@movie.errors[:title]).to include("can't be blank")
    end

    it "should be invalid without a released_on date" do
      expect(@movie).not_to be_valid
      expect(@movie.errors[:released_on]).to include("can't be blank")
    end

    it "should be invalid without a duration" do
      expect(@movie).not_to be_valid
      expect(@movie.errors[:duration]).to include("can't be blank")
    end

    it "should be invalid without a 25 length description" do
      @movie.description = "Too short"
      @movie.valid?
      expect(@movie.errors[:description]).to include("is too short (minimum is 25 characters)")
    end

    it "should have a total_gross greater than or equal to 0" do
      expect(@movie).not_to be_valid
      expect(@movie.errors[:total_gross]).to include("must be greater than or equal to 0")
    end

    it "should have a valid image file name" do
      expect(@movie).not_to be_valid
      expect(@movie.errors[:image_file_name]).to include("must be a JPG or PNG image")
    end

    it "should have a valid rating" do
      @movie.rating = "Invalid Rating"
      @movie.valid?
      expect(@movie.errors[:rating]).to include("is not included in the list")
    end
  end
end

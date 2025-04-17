require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "it should be invalid without correct validations" do
    before do
      @review = Review.new(name: nil, stars: nil, comment: nil)
    end

    it "should be invalid with a title" do
      expect(@review).not_to be_valid
      expect(@review.errors[:name]).to include("can't be blank")
    end

    it "should be invalid with a comment less than four characters" do
      @review.comment = "Ho"
      expect(@review).not_to be_valid
      expect(@review.errors[:comment]).to include("is too short (minimum is 4 characters)")
    end

    it "should be invalid without correct stars" do
      @review.stars = -1
      expect(@review).not_to be_valid
      expect(@review.errors[:stars]).to include("must be between 1 and 5")
    end
  end
end

require 'rails_helper'

RSpec.describe "Movies", type: :request do
  describe "GET /movies" do
    before { get "/movies" }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end
end

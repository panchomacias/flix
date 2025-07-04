require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/sessions/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/sessions/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/sessions/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end

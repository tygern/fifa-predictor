require 'rails_helper'

RSpec.describe "Teams", type: :request do
  describe "GET /teams" do
    it "works! (now write some real specs)" do
      create_team(name: "Pickles")
      create_team(name: "Chicken")

      get teams_path
      expect(response).to have_http_status(200)
      expect(response.body).to include("Pickles")
      expect(response.body).to include("Chicken")
    end
  end
end

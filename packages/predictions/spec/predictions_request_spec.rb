describe "/predictions", type: :request do
  let(:home_team) { create_team }
  let(:away_team) { create_team }
  let(:valid_attributes) { {
    home_team_id: home_team.id,
    away_team_id: away_team.id,
  } }

  describe "GET /index" do
    it "renders a successful response" do
      get predictions_url
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    it "displays the result" do
      create_match_result(
        home_team_id: home_team.id,
        home_goals: 90,
        home_red_cards: 0,
        away_team_id: away_team.id,
        away_goals: 0,
        away_red_cards: 0,
      )

      post predictions_url, params: { fixture: valid_attributes }

      expect(response).to be_successful
      expect(response.body).to include("home")
      expect(response.body).to include("100.0%")
    end
  end
end

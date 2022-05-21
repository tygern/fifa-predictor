require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/match_results", type: :request do

  # This should return the minimal set of attributes required to create a valid
  # MatchResult. As you add validations to MatchResult, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      home_team: Team.create!(name: "Winner"),
      home_goals: 1,
      home_red_cards: 4,
      away_team: Team.create!(name: "Loser"),
      away_goals: 3,
      away_red_cards: 0,
    }
  }

  let(:invalid_attributes) { {} }

  describe "GET /index" do
    it "renders a successful response" do
      MatchResult.create! valid_attributes
      get match_results_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      match_result = MatchResult.create! valid_attributes
      get match_result_url(match_result)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_match_result_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      match_result = MatchResult.create! valid_attributes
      get edit_match_result_url(match_result)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new MatchResult" do
        expect {
          post match_results_url, params: { match_result: valid_attributes }
        }.to change(MatchResult, :count).by(1)
      end

      it "redirects to the created match_result" do
        post match_results_url, params: { match_result: valid_attributes }
        expect(response).to redirect_to(match_result_url(MatchResult.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new MatchResult" do
        expect {
          post match_results_url, params: { match_result: invalid_attributes }
        }.to change(MatchResult, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post match_results_url, params: { match_result: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested match_result" do
        match_result = MatchResult.create! valid_attributes
        patch match_result_url(match_result), params: { match_result: new_attributes }
        match_result.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the match_result" do
        match_result = MatchResult.create! valid_attributes
        patch match_result_url(match_result), params: { match_result: new_attributes }
        match_result.reload
        expect(response).to redirect_to(match_result_url(match_result))
      end
    end

    context "with invalid parameters" do

      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        match_result = MatchResult.create! valid_attributes
        patch match_result_url(match_result), params: { match_result: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested match_result" do
      match_result = MatchResult.create! valid_attributes
      expect {
        delete match_result_url(match_result)
      }.to change(MatchResult, :count).by(-1)
    end

    it "redirects to the match_results list" do
      match_result = MatchResult.create! valid_attributes
      delete match_result_url(match_result)
      expect(response).to redirect_to(match_results_url)
    end
  end
end
require 'rails_helper'

RSpec.describe "/match_results", type: :request do
  let(:valid_attributes) { match_result_params }
  let(:invalid_attributes) { match_result_params(home_goals: -1) }

  describe "GET /index" do
    it "renders a successful response" do
      MatchResult.create! valid_attributes
      get match_results_url
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

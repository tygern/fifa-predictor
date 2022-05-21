require "rails_helper"

RSpec.describe MatchResultsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/match_results").to route_to("match_results#index")
    end

    it "routes to #new" do
      expect(get: "/match_results/new").to route_to("match_results#new")
    end

    it "routes to #show" do
      expect(get: "/match_results/1").to route_to("match_results#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/match_results/1/edit").to route_to("match_results#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/match_results").to route_to("match_results#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/match_results/1").to route_to("match_results#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/match_results/1").to route_to("match_results#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/match_results/1").to route_to("match_results#destroy", id: "1")
    end
  end
end

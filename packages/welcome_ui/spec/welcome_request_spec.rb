RSpec.describe "Welcome", type: :request do
  describe "GET /" do
    it "welcomes" do
      get root_path

      expect(response).to have_http_status(200)
      expect(response.body).to include("FIFA predictor")
    end
  end
end
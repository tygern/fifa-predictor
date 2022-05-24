class PredictionsController < ApplicationController
  def index
    @teams = Team.all
    @prediction = nil
  end

  def create
    scoring_rates = ScoringRates.new(MatchResult.all)
    simulator = Simulator.new(scoring_rates)
    predictor = Predictor.new(simulator, Rails.configuration.number_of_simulations)

    home_team = Team.find(fixture_params[:home_team_id])
    away_team = Team.find(fixture_params[:away_team_id])

    @prediction = predictor.predict(Fixture.new(home_team, away_team))
    @home_team = TeamPresenter.new(home_team)
    @away_team = TeamPresenter.new(away_team)
    render :show
  end

  private

  def fixture_params
    params.require(:fixture).permit(:home_team_id, :away_team_id)
  end
end
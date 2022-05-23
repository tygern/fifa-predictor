require "rails_helper"

describe Predictor do
  it "predicts" do
    scores_a_lot = new_team
    not_so_good = new_team
    lots_of_reds = new_team

    match_results = [
      MatchResult.new(home_team: scores_a_lot, home_goals: 90, home_red_cards: 0, away_team: not_so_good, away_goals: 0, away_red_cards: 0),
      MatchResult.new(home_team: lots_of_reds, home_goals: 0, home_red_cards: 90, away_team: scores_a_lot, away_goals: 90, away_red_cards: 0),
    ]

    predictor = Predictor.new(Simulator.new(ScoringRates.new(match_results)), 10)

    expect(predictor.predict(Fixture.new(scores_a_lot, not_so_good))).to eq(Prediction.new(1.0, 0.0, 0.0))
    expect(predictor.predict(Fixture.new(scores_a_lot, lots_of_reds))).to eq(Prediction.new(0.0, 1.0, 0.0))
  end
end

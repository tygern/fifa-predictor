require 'rails_helper'

describe ScoringRates do
  it "calculates" do
    good = new_team
    better = new_team

    match_results = [
      MatchResult.new(home_team: good, home_goals: 17, home_red_cards: 8, away_team: better, away_goals: 26, away_red_cards: 35, duration: 90),
      MatchResult.new(home_team: good, home_goals: 19, home_red_cards: 10, away_team: better, away_goals: 28, away_red_cards: 37, duration: 90),
      MatchResult.new(home_team: good, home_goals: 2, home_red_cards: 1, away_team: better, away_goals: 3, away_red_cards: 4, duration: 10),
    ]

    rates = ScoringRates.new(match_results)

    expect(rates.goals_scored_per_minute(good)).to eq(0.2)
    expect(rates.reds_per_minute(good)).to eq(0.1)
    expect(rates.defensive_factor(good)).to eq(1.2)
    expect(rates.red_concession_factor(good)).to eq(1.6)

    expect(rates.goals_scored_per_minute(better)).to eq(0.3)
    expect(rates.reds_per_minute(better)).to eq(0.4)
    expect(rates.defensive_factor(better)).to eq(0.8)
    expect(rates.red_concession_factor(better)).to eq(0.4)
  end
end

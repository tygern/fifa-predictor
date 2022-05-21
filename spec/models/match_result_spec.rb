require 'rails_helper'

RSpec.describe MatchResult, type: :model do
  it "#results home" do
    match_result = MatchResult.new(
      {
        home_team: Team.new({name: "Winner"}),
        home_goals: 1,
        home_red_cards: 4,
        away_team: Team.new({name: "Loser"}),
        away_goals: 3,
        away_red_cards: 0,
      }
    )

    expect(match_result.result).to eq :home
  end

  it "#results away" do
    match_result = MatchResult.new(
      {
        home_team: Team.new({name: "Not the winner"}),
        home_goals: 1,
        home_red_cards: 4,
        away_team: Team.new({name: "Not the loser"}),
        away_goals: 7,
        away_red_cards: 0,
      }
    )

    expect(match_result.result).to eq :away
  end

  it "#results draw" do
    match_result = MatchResult.new(
      {
        home_team: Team.new({name: "Drawer"}),
        home_goals: 1,
        home_red_cards: 4,
        away_team: Team.new({name: "Tier"}),
        away_goals: 5,
        away_red_cards: 0,
      }
    )

    expect(match_result.result).to eq :draw
  end
end

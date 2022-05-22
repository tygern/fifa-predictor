require 'rails_helper'

RSpec.describe MatchResult, type: :model do
  it "#results home" do
    match_result = new_match_result(
      home_goals: 1,
      home_red_cards: 4,
      away_goals: 3,
      away_red_cards: 0,
    )

    expect(match_result.result).to eq :home
  end

  it "#results away" do
    match_result = new_match_result(
      home_goals: 1,
      home_red_cards: 4,
      away_goals: 3,
      away_red_cards: 3,
    )

    expect(match_result.result).to eq :away
  end

  it "#results draw" do
    match_result = new_match_result(
      home_goals: 1,
      home_red_cards: 4,
      away_goals: 3,
      away_red_cards: 2,
    )

    expect(match_result.result).to eq :draw
  end

  it "keeps associations for discarded teams" do
    home_team_to_discard = create_team
    away_team_to_discard = create_team
    match_result = create_match_result(
      home_team_id: home_team_to_discard.id,
      away_team_id: away_team_to_discard.id,
    )

    home_team_to_discard.discard!
    away_team_to_discard.discard!

    match_result.reload
    expect(match_result.home_team).to_not be_nil
    expect(match_result.away_team).to_not be_nil
  end
end

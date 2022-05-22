require 'rails_helper'

RSpec.describe MatchResultPresenter do
  it "#results home" do
    match_result = MatchResultPresenter.new(new_match_result(
      home_goals: 1,
      home_red_cards: 4,
      away_goals: 3,
      away_red_cards: 0,
      ))

    expect(match_result.result).to eq :home
  end

  it "#results away" do
    match_result = match_result = MatchResultPresenter.new(new_match_result(
      home_goals: 1,
      home_red_cards: 4,
      away_goals: 3,
      away_red_cards: 3,
      ))

    expect(match_result.result).to eq :away
  end

  it "#results draw" do
    match_result = match_result = MatchResultPresenter.new(new_match_result(
      home_goals: 1,
      home_red_cards: 4,
      away_goals: 3,
      away_red_cards: 2,
      ))

    expect(match_result.result).to eq :draw
  end
end

require 'rails_helper'

describe TeamPresenter do
  it "badge label" do
    expect(TeamPresenter.new(new_team(name: "Pickles")).badge_label).to eq("P")
    expect(TeamPresenter.new(new_team(name: "pickles")).badge_label).to eq("P")
  end

  it "badge color is deterministic, using the team and id" do
    expect(TeamPresenter.new(new_team(id: 1, name: "Pickles")).badge_color).to eq("#eeea94")
    expect(TeamPresenter.new(new_team(id: 2, name: "Pickles")).badge_color).to eq("#6b8ae9")
    expect(TeamPresenter.new(new_team(id: 2, name: "Chicken")).badge_color).to eq("#41e729")
  end
end

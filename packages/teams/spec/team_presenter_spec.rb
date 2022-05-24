require 'rails_helper'

describe TeamPresenter do
  it "badge label" do
    expect(TeamPresenter.new(new_team(name: "Pickles")).badge_label).to eq("P")
    expect(TeamPresenter.new(new_team(name: "pickles")).badge_label).to eq("P")
  end

  it "badge color is deterministic" do
    expect(TeamPresenter.new(new_team(name: "Pickles")).badge_color).to eq("#75238f")
  end
end

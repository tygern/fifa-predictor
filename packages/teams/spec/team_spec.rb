require 'rails_helper'

RSpec.describe Team, type: :model do
  it "soft deletes" do
    team = create_team
    deleted_team = create_team
    deleted_team.discard!

    expect(Team.all).to include(team)
    expect(Team.all).to_not include(deleted_team)

    expect(Team.with_discarded).to include(team)
    expect(Team.with_discarded).to include(deleted_team)
  end

  it "allows re-creation" do
    create_team(name: "Pickles").discard!
    expect(Team.find_by(name: "Pickles")).to be_nil

    create_team(name: "Pickles")
    expect(Team.find_by(name: "Pickles")).to_not be_nil
  end
end

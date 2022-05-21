require 'rails_helper'

RSpec.describe Team, type: :model do
  it "soft deletes" do
    create_team(name: "Pickles")
    chicken = create_team(name: "Chicken")

    chicken.discard!

    expect(Team.all.size).to eq(1)
    expect(Team.with_discarded.size).to eq(2)
  end

  it "allows re-creation" do
    create_team(name: "Pickles").discard!
    expect(Team.all.size).to eq(0)

    create_team(name: "Pickles")
    expect(Team.all.size).to eq(1)
  end
end

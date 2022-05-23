require_relative "../app/outcome"

describe "outcome" do
  it "counts red cards" do
    expect(calculate_outcome(
             home_goals: 1,
             home_reds: 4,
             away_goals: 2,
             away_reds: 2,
             duration: 90
           )).to eq(:home)

    expect(calculate_outcome(
             home_goals: 1,
             home_reds: 2,
             away_goals: 3,
             away_reds: 2,
             duration: 90
           )).to eq(:away)

    expect(calculate_outcome(
             home_goals: 4,
             home_reds: 1,
             away_goals: 3,
             away_reds: 2,
             duration: 90
           )).to eq(:draw)
  end

  it "handles 5 red cards" do
    expect(calculate_outcome(
             home_goals: 1,
             home_reds: 5,
             away_goals: 12,
             away_reds: 2,
             duration: 90
           )).to eq(:draw)

    expect(calculate_outcome(
             home_goals: 1,
             home_reds: 5,
             away_goals: 12,
             away_reds: 2,
             duration: 44
           )).to eq(:home)

    expect(calculate_outcome(
             home_goals: 12,
             home_reds: 1,
             away_goals: 1,
             away_reds: 5,
             duration: 90
           )).to eq(:draw)

    expect(calculate_outcome(
             home_goals: 12,
             home_reds: 1,
             away_goals: 2,
             away_reds: 5,
             duration: 44
           )).to eq(:away)
  end
end

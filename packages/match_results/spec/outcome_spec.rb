require_relative "../app/outcome"

describe "outcome" do
  it "counts red cards" do
    expect(calculate_outcome(1, 4, 2, 2, 90)).to eq(:home)
    expect(calculate_outcome(1, 2, 3, 2, 90)).to eq(:away)
    expect(calculate_outcome(4, 1, 3, 2, 90)).to eq(:draw)
  end

  it "handles 5 red cards" do
    expect(calculate_outcome(1, 5, 12, 2, 90)).to eq(:draw)
    expect(calculate_outcome(1, 5, 12, 2, 44)).to eq(:home)
    expect(calculate_outcome(12, 1, 1, 5, 90)).to eq(:draw)
    expect(calculate_outcome(12, 1, 2, 5, 44)).to eq(:away)
  end
end

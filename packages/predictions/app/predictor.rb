class Fixture
  attr_reader :home_team, :away_team

  def initialize(home_team, away_team)
    @home_team = home_team
    @away_team = away_team
  end
end

class Prediction
  attr_reader :home, :away, :draw

  def initialize(home, away, draw)
    @home = home
    @away = away
    @draw = draw
  end

  def ==(other)
    @home == other.home &&
    @away == other.away &&
    @draw == other.draw
  end
end

class Predictor
  def initialize(simulator, number_of_simulations)
    @simulator = simulator
    @number_of_simulations = number_of_simulations
  end

  def predict(fixture)
    results = (1..@number_of_simulations).map { @simulator.play(fixture) }

    home_count = results.count { |result| result == :home }
    away_count = results.count { |result| result == :away }
    draw_count = results.count { |result| result == :draw }

    Prediction.new(
      home_count.to_f / @number_of_simulations,
      away_count.to_f / @number_of_simulations,
      draw_count.to_f / @number_of_simulations,
    )
  end
end

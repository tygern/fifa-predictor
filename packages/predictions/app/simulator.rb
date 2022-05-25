require_relative '../../match_results/app/outcome'

class Simulator
  def initialize(scoring_rates)
    @scoring_rates = scoring_rates
  end

  def play(fixture)
    game = Game.new(
      home_goal_rate: home_goal_rate(fixture),
      home_reds_rate: home_reds_rate(fixture),
      away_goals_rate: away_goals_rate(fixture),
      away_reds_rate: away_reds_rate(fixture),
    )

    game.play_for(90)

    if game.should_go_to_extra_time
      game.play_for(30)
    end

    game.result
  end

  private

  def home_goal_rate(fixture)
    @scoring_rates.goals_scored_per_minute(fixture.home_team) * [@scoring_rates.defensive_factor(fixture.away_team), 0.5].max
  end

  def home_reds_rate(fixture)
    @scoring_rates.reds_per_minute(fixture.home_team) * [@scoring_rates.red_concession_factor(fixture.away_team), 0.5].max
  end

  def away_reds_rate(fixture)
    @scoring_rates.reds_per_minute(fixture.away_team) * [@scoring_rates.red_concession_factor(fixture.home_team), 0.5].max
  end

  def away_goals_rate(fixture)
    @scoring_rates.goals_scored_per_minute(fixture.away_team) * [@scoring_rates.defensive_factor(fixture.home_team), 0.5].max
  end
end

class Game
  def initialize(home_goal_rate:, home_reds_rate:, away_goals_rate:, away_reds_rate:)
    @home_goal_rate = home_goal_rate
    @home_reds_rate = home_reds_rate
    @away_goals_rate = away_goals_rate
    @away_reds_rate = away_reds_rate

    @scenario = Scenario.new
  end

  def play_for(number_of_minutes)
    number_of_minutes.times do
      @scenario.add_home_goal if rand <= @home_goal_rate
      @scenario.add_home_red_card if rand <= @home_reds_rate
      break if @scenario.home_reds >= 5

      @scenario.add_away_goal if rand <= @away_goals_rate
      @scenario.add_away_red_card if rand <= @away_reds_rate
      break if @scenario.away_reds >= 5

      @scenario.tick_clock
    end
  end

  def should_go_to_extra_time
    @scenario.duration == 90 && @scenario.home_goals == @scenario.away_goals
  end

  def result
    calculate_outcome(
      home_goals: @scenario.home_goals,
      home_reds: @scenario.home_reds,
      away_goals: @scenario.away_goals,
      away_reds: @scenario.away_reds,
      duration: @scenario.duration,
    )
  end
end

class Scenario
  attr_reader :home_goals, :home_reds, :away_goals, :away_reds, :duration

  def initialize
    @home_goals = 0
    @home_reds = 0
    @away_goals = 0
    @away_reds = 0
    @duration = 0
  end

  def tick_clock
    @duration += 1
  end

  def add_home_goal
    @home_goals += 1
  end

  def add_home_red_card
    @home_reds += 1
  end

  def add_away_goal
    @away_goals += 1
  end

  def add_away_red_card
    @away_reds += 1
  end
end
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
    @scoring_rates.goals_scored_per_minute(fixture.home_team) * @scoring_rates.defensive_factor(fixture.away_team)
  end

  def home_reds_rate(fixture)
    @scoring_rates.reds_per_minute(fixture.home_team) * @scoring_rates.red_concession_factor(fixture.away_team)
  end

  def away_reds_rate(fixture)
    @scoring_rates.reds_per_minute(fixture.away_team) * @scoring_rates.red_concession_factor(fixture.home_team)
  end

  def away_goals_rate(fixture)
    @scoring_rates.goals_scored_per_minute(fixture.away_team) * @scoring_rates.defensive_factor(fixture.home_team)
  end
end

class Game
  def initialize(home_goal_rate:, home_reds_rate:, away_goals_rate:, away_reds_rate:)
    @home_goal_rate = home_goal_rate
    @home_reds_rate = home_reds_rate
    @away_goals_rate = away_goals_rate
    @away_reds_rate = away_reds_rate

    @home_goals = 0
    @home_reds = 0
    @away_goals = 0
    @away_reds = 0
    @duration = 0
  end

  def play_for(number_of_minutes)
    number_of_minutes.times do
      @home_goals += 1 if rand <= @home_goal_rate
      @home_reds += 1 if rand <= @home_reds_rate
      break if @home_reds >= 5

      @away_goals += 1 if rand <= @away_goals_rate
      @away_reds += 1 if rand <= @away_reds_rate
      break if @away_reds >= 5

      @duration += 1
    end
  end

  def should_go_to_extra_time
    @duration == 90 && @home_goals == @away_goals
  end

  def result
    calculate_outcome(@home_goals, @home_reds, @away_goals, @away_reds, @duration)
  end
end

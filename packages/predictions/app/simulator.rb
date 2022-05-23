require_relative '../../match_results/app/outcome'

class Simulator
  def initialize(scoring_rates)
    @scoring_rates = scoring_rates
  end

  def play(fixture)
    home_goals = 0
    home_reds = 0
    away_goals = 0
    away_reds = 0
    latest_minute = 0

    90.times do |minute|
      home_goals += 1 if rand <= home_goal_rate(fixture)
      home_reds += 1 if rand <= home_reds_rate(fixture)
      break if home_reds == 5

      away_goals += 1 if rand <= away_goals_rate(fixture)
      away_reds += 1 if rand <= away_reds_rate(fixture)
      break if away_reds == 5

      latest_minute = minute
    end

    calculate_outcome(home_goals, home_reds, away_goals, away_reds, latest_minute + 1)
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

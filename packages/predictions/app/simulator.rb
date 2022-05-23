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
    duration = 0

    play_for = -> (number_of_minutes) {
      number_of_minutes.times do
        home_goals += 1 if rand <= home_goal_rate(fixture)
        home_reds += 1 if rand <= home_reds_rate(fixture)
        break if home_reds >= 5

        away_goals += 1 if rand <= away_goals_rate(fixture)
        away_reds += 1 if rand <= away_reds_rate(fixture)
        break if away_reds >= 5

        duration += 1
      end
    }

    play_for.call(90)

    if duration == 90 && home_goals == away_goals
      play_for.call(30)
    end

    calculate_outcome(home_goals, home_reds, away_goals, away_reds, duration)
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

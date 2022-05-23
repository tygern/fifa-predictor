class TeamScoring
  attr_reader :goals_scored, :goals_conceded, :reds_scored, :reds_conceded, :minutes

  def initialize(goals_scored, goals_conceded, reds_scored, reds_conceded, minutes)
    @goals_scored = goals_scored
    @goals_conceded = goals_conceded
    @reds_scored = reds_scored
    @reds_conceded = reds_conceded
    @minutes = minutes
  end

  def goals_scored_per_minute
    if self.minutes == 0
      1 / 90.0
    else
      @goals_scored / @minutes.to_f
    end
  end

  def goals_conceded_per_minute
    if self.minutes == 0
      3
    else
      @goals_conceded / @minutes.to_f
    end
  end

  def reds_per_minute
    if self.minutes == 0
      0
    else
      @reds_scored / @minutes.to_f
    end
  end

  def reds_conceded_per_minute
    if self.minutes == 0
      2
    else
      @reds_conceded / @minutes.to_f
    end
  end
end

class ScoringRates
  def initialize(match_results)
    @scoring_hash = {}
    @total_goals = 0
    @total_reds = 0
    @total_minutes = 0

    match_results.each { |result|
      add_result(result)
    }
  end

  def defensive_factor(team)
    scoring = @scoring_hash[team.name]
    if scoring.nil?
      return 1
    end

    scoring.goals_conceded_per_minute / average_goals_per_minute
  end

  def red_concession_factor(team)
    scoring = @scoring_hash[team.name]
    if scoring.nil?
      return 1
    end

    scoring.reds_conceded_per_minute / average_reds_per_minute
  end

  def goals_scored_per_minute(team)
    @scoring_hash[team.name]&.goals_scored_per_minute || 1 / 90.0
  end

  def reds_per_minute(team)
    @scoring_hash[team.name]&.reds_per_minute || 0
  end

  private

  def add_result(result)
    home_scoring = @scoring_hash[result.home_team.name] || TeamScoring.new(0, 0, 0, 0, 0)
    @scoring_hash[result.home_team.name] = TeamScoring.new(
      home_scoring.goals_scored + result.home_goals,
      home_scoring.goals_conceded + result.away_goals,
      home_scoring.reds_scored + result.home_red_cards,
      home_scoring.reds_conceded + result.away_red_cards,
      home_scoring.minutes + result.duration
    )

    away_scoring = @scoring_hash[result.away_team.name] || TeamScoring.new(0, 0, 0, 0, 0)
    @scoring_hash[result.away_team.name] = TeamScoring.new(
      away_scoring.goals_scored + result.away_goals,
      away_scoring.goals_conceded + result.home_goals,
      away_scoring.reds_scored + result.away_red_cards,
      away_scoring.reds_conceded + result.home_red_cards,
      away_scoring.minutes + result.duration
    )

    @total_goals += result.home_goals + result.away_goals
    @total_reds += result.home_red_cards + result.away_red_cards
    @total_minutes += result.duration
  end

  def average_goals_per_minute
    @total_goals / @total_minutes.to_f / 2.0
  end

  def average_reds_per_minute
    @total_reds / @total_minutes.to_f / 2.0
  end
end

class TeamScoring
  attr_reader :goals_scored, :goals_conceded, :reds_scored, :reds_conceded, :matches

  def initialize(goals_scored, goals_conceded, reds_scored, reds_conceded, matches)
    @goals_scored = goals_scored
    @goals_conceded = goals_conceded
    @reds_scored = reds_scored
    @reds_conceded = reds_conceded
    @matches = matches
  end

  def goals_scored_per_minute
    if self.matches == 0
      1 / 90.0
    else
      @goals_scored / 90.0 / @matches
    end
  end

  def goals_conceded_per_match
    if self.matches == 0
      3
    else
      @goals_conceded / @matches
    end
  end

  def reds_per_minute
    if self.matches == 0
      0
    else
      @reds_scored / 90.0 / @matches
    end
  end

  def reds_conceded_per_match
    if self.matches == 0
      2
    else
      @reds_conceded / @matches
    end
  end
end

class ScoringRates
  def initialize(match_results)
    @scoring_hash = {}
    @total_goals = 0
    @total_reds = 0
    @total_matches = 0

    match_results.each { |result|
      add_result(result)
    }
  end

  def defensive_factor(team)
    scoring = @scoring_hash[team.name]
    if scoring.nil?
      return 1
    end

    goals_conceded_per_match = global_goals_per_match / 2.0
    scoring.goals_conceded_per_match / goals_conceded_per_match
  end

  def red_concession_factor(team)
    scoring = @scoring_hash[team.name]
    if scoring.nil?
      return 1
    end

    reds_conceded_per_match = global_reds_per_match / 2.0
    scoring.reds_conceded_per_match / reds_conceded_per_match
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
      home_scoring.matches + 1
    )

    away_scoring = @scoring_hash[result.away_team.name] || TeamScoring.new(0, 0, 0, 0, 0)
    @scoring_hash[result.away_team.name] = TeamScoring.new(
      away_scoring.goals_scored + result.away_goals,
      away_scoring.goals_conceded + result.home_goals,
      away_scoring.reds_scored + result.away_red_cards,
      away_scoring.reds_conceded + result.home_red_cards,
      away_scoring.matches + 1
    )

    @total_goals += result.home_goals + result.away_goals
    @total_reds += result.home_red_cards + result.away_red_cards
    @total_matches += 1
  end

  def global_goals_per_match
    @total_goals / @total_matches.to_f
  end

  def global_reds_per_match
    @total_reds / @total_matches.to_f
  end
end

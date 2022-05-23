require_relative "outcome"

class MatchResultPresenter
  def initialize(model)
    @id = model.id
    @home_team = model.home_team.name
    @home_goals = model.home_goals
    @home_red_cards = model.home_red_cards
    @away_team = model.away_team.name
    @away_goals = model.away_goals
    @away_red_cards = model.away_red_cards
    @duration = model.duration
  end

  def home_score
    home_red_cards + home_goals
  end

  def away_score
    away_red_cards + away_goals
  end

  def result
    calculate_outcome(
      home_goals: home_goals,
      home_reds: home_red_cards,
      away_goals: away_goals,
      away_reds: away_red_cards,
      duration: duration,
    )
  end

  attr_reader :id,
              :home_team,
              :home_goals,
              :home_red_cards,
              :away_team,
              :away_goals,
              :away_red_cards,
              :duration
end
class MatchResultPresenter
  def initialize(model)
    @model = model
  end

  def id
    model.id
  end

  def result
    model.result
  end

  def home_team
    model.home_team.name
  end

  def home_goals
    model.home_goals
  end

  def home_red_cards
    model.home_red_cards
  end

  def home_score
    home_red_cards + home_goals
  end

  def away_team
    model.away_team.name
  end

  def away_goals
    model.away_goals
  end

  def away_red_cards
    model.away_red_cards
  end

  def away_score
    away_red_cards + away_goals
  end

  private

  attr_reader :model
end
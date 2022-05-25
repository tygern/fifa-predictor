class Outcome
end

def calculate_outcome(home_goals:, home_reds:, away_goals:, away_reds:, duration:)
  if home_reds == 5
    return duration <= 45 ? :home : :draw
  end

  if away_reds == 5
    return duration <= 45 ? :away : :draw
  end

  home_score = home_goals + home_reds
  away_score = away_goals + away_reds

  if home_score > away_score
    :home
  elsif away_score > home_score
    :away
  else
    :draw
  end
end

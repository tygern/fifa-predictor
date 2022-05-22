class MatchResult < ApplicationRecord
  include Discard::Model
  default_scope -> { kept }

  belongs_to :home_team, -> { unscope(where: :discarded_at) }, class_name: "Team", foreign_key: :home_team_id
  belongs_to :away_team, -> { unscope(where: :discarded_at) }, class_name: "Team", foreign_key: :away_team_id

  validates :home_team, presence: true, comparison: { other_than: :away_team }
  validates :home_goals, presence: true, comparison: { greater_than_or_equal_to: 0 }, numericality: { only_integer: true }
  validates :home_red_cards, presence: true, comparison: { greater_than_or_equal_to: 0 }, numericality: { only_integer: true }

  validates :away_team, presence: true, comparison: { other_than: :home_team }
  validates :away_goals, presence: true, comparison: { greater_than_or_equal_to: 0 }, numericality: { only_integer: true }
  validates :away_red_cards, presence: true, comparison: { greater_than_or_equal_to: 0 }, numericality: { only_integer: true }
end

class Team < ApplicationRecord
  include Discard::Model
  default_scope -> { kept }

  validates :name, presence: true, uniqueness: { conditions: -> { kept } }
end

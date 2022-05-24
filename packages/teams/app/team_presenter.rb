require 'digest/sha1'

class TeamPresenter
  attr_reader :id, :name

  def initialize(model)
    @id = model.id
    @name = model.name
  end

  def badge_color
    "#" + Digest::SHA1.hexdigest(@name).to_s.slice(4, 6)
  end

  def badge_label
    @name[0].capitalize
  end
end
class TeamPresenter
  attr_reader :id, :name

  def initialize(model)
    @id = model.id
    @name = model.name
  end

  def badge_color
    "#" + @name.hash.to_s(16).slice(1, 6)
  end

  def badge_label
    @name[0]
  end
end
class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @ship.hit unless empty?
    @fired_upon = true
  end

  def render(show = false)
    if fired_upon? && !empty? && ship.sunk?
     "X"
    elsif fired_upon? && !empty?
     "H"
    elsif fired_upon?
     "M"
    elsif show == true && !empty?
     "S"
    else
     "."
    end
  end
end

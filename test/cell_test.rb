require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def test_it_exists
    cell = Cell.new("B4")

    assert_instance_of Cell, cell
  end

  def test_it_has_attributes
    cell = Cell.new("B4")

    assert_equal "B4", cell.coordinate
  end

  def test_it_has_no_ship_initially
    cell = Cell.new("B4")

    assert_nil cell.ship
    assert cell.empty?
  end

  def test_it_can_place_ship
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)

    assert_equal cruiser, cell.ship
    refute cell.empty?
  end

  def test_it_is_not_fired_upon_initially
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)

    refute cell.fired_upon?
  end

  def test_it_can_be_fired_upon
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)
    cell.fire_upon

    assert_equal 2, cell.ship.health
    assert cell.fired_upon?
  end

  def test_it_can_render_dot
    cell_1 = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell_1.place_ship(cruiser)

    assert_equal ".", cell_1.render
  end

  def test_it_can_render_it_M
    cell_1 = Cell.new("B4")

    cell_1.fire_upon

    assert_equal "M", cell_1.render
  end

  def test_it_can_render_S
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    cell_2.place_ship(cruiser)

    assert_equal "S", cell_2.render(true)
  end

  def test_it_can_render_H
   cell_2 = Cell.new("C3")
   cruiser = Ship.new("Cruiser", 3)

   cell_2.place_ship(cruiser)
   cell_2.fire_upon

   assert_equal "H", cell_2.render
  end

  def test_it_can_render_X
   cell_2 = Cell.new("C3")
   cruiser = Ship.new("Cruiser", 3)

   cell_2.place_ship(cruiser)
   cell_2.fire_upon

   refute cruiser.sunk?

   cruiser.hit
   cruiser.hit

   assert cruiser.sunk?
   assert_equal "X", cell_2.render
  end
end

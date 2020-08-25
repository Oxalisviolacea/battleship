require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test
  def test_it_exists
    ship = Ship.new("cruiser", 3)

    assert_instance_of Ship, ship
  end

  def test_it_has_attributes
    ship = Ship.new("cruiser", 3)

    assert_equal "cruiser", ship.name
    assert_equal 3, ship.length
  end

  def test_it_has_health
    ship = Ship.new("cruiser", 3)

    assert_equal 3, ship.health
  end

  def test_it_is_not_sunk_initially
    ship = Ship.new("cruiser", 3)

    refute ship.sunk?
  end
end

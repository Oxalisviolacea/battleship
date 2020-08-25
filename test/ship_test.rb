require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test
  def test_it_exists
    ship = Ship.new("cruiser", 3)

    assert_instance_of Ship, ship
  end
end

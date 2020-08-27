require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/turn'

class TurnTest < Minitest::Test

  def test_it_exists
    turn = Turn.new

    assert_instance_of Turn, turn
  end

end

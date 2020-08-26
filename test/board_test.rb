require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test
  def test_it_exists
    board = Board.new

    assert_instance_of Board, board
  end

  def test_it_has_cells
    board = Board.new

    assert_instance_of Hash, board.cells
    assert_equal 16, board.cells.length
    assert_instance_of Cell, board.cells["A1"]
  end
end

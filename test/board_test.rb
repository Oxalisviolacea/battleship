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

  def test_valid_coordinates
    board = Board.new

    assert board.valid_coordinate?("A1")
    assert board.valid_coordinate?("D4")
    refute board.valid_coordinate?("A5")
    refute board.valid_coordinate?("E1")
    refute board.valid_coordinate?("A22")
  end

  def test_valid_placement_ship_length
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    refute board.valid_placement?(cruiser, ["A1", "A2"])
    refute board.valid_placement?(submarine, ["A2", "A3", "A4"])
    assert board.valid_placement?(cruiser, ["A1", "A2", "A3"])
    assert board.valid_placement?(submarine, ["A2", "A3"])
  end

  def test_if_coordinates_are_consecutive
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    refute board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    refute board.valid_placement?(submarine, ["A1", "C1"])
    refute board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    refute board.valid_placement?(submarine, ["C1", "B1"])
    assert board.valid_placement?(cruiser, ["A1", "A2", "A3"])
    assert board.valid_placement?(submarine, ["A1", "B1"])
  end

  def test_it_has_no_diagonals
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    refute board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    refute board.valid_placement?(submarine, ["C2", "D3"])
    assert board.valid_placement?(cruiser, ["A1", "B1", "C1"])
    assert board.valid_placement?(submarine, ["C2", "C3"])
  end
end

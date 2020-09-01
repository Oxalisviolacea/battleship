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

  def test_it_has_length_and_width
    board = Board.new(3, 5)

    assert_equal 3, board.width
    assert_equal 5, board.height
  end

  def test_it_has_rows_and_columns
    board = Board.new(3, 5)

    assert_equal ["A", "B", "C", "D", "E"], board.rows
    assert_equal ["1", "2", "3"], board.columns
  end

  def test_it_can_generate_board
    board = Board.new(3,3)

    cells = ["A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3"]

    assert_equal cells, board.generate_board.keys
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

  def test_it_can_place_ship
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    assert_equal cruiser, cell_1.ship
    assert_equal cruiser, cell_2.ship
    assert_equal cruiser, cell_3.ship
    assert cell_3.ship == cell_2.ship
  end

  def test_ships_do_not_overlap
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert board.valid_placement?(cruiser, ["A1", "A2", "A3"])

    board.place(cruiser, ["A1", "A2", "A3"])

    refute board.valid_placement?(submarine, ["A1", "B1"])
  end

  def test_it_can_render_board
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["B2", "B3", "B4"])
    board_output = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    board_output_optional = "  1 2 3 4 \nA . . . . \nB . S S S \nC . . . . \nD . . . . \n"

    assert_equal board_output, board.render
    assert_equal board_output_optional, board.render(true)
  end
end

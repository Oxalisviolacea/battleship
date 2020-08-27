require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/turn'

class TurnTest < Minitest::Test

  def test_it_exists
    player_board = Board.new
    computer_board = Board.new

    turn = Turn.new(player_board, computer_board)

    assert_instance_of Turn, turn
  end

  def test_it_has_a_two_boards
    player_board = Board.new
    computer_board = Board.new

    turn = Turn.new(player_board, computer_board)

    assert_instance_of Board, turn.player_board
    assert_instance_of Board, turn.computer_board
  end

  def test_it_can_display_both_boards
    player_board = Board.new
    computer_board = Board.new

    turn = Turn.new(player_board, computer_board)

    boards = "=============COMPUTER BOARD=============\n" +
             "  1 2 3 4 \n" +
              "A . . . . \n" +
              "B . . . . \n" +
              "C . . . . \n" +
              "D . . . . \n" +
              "==============PLAYER BOARD==============\n" +
              "  1 2 3 4 \n" +
              "A . . . . \n" +
              "B . . . . \n" +
              "C . . . . \n" +
              "D . . . . \n"

    assert_equal boards, turn.display_boards
  end

  def test_player_can_fire
    player_board = Board.new
    computer_board = Board.new

    turn = Turn.new(player_board, computer_board)
    turn.player_shot("A1")

    assert computer_board.cells["A1"].fired_upon?
    refute computer_board.cells["A2"].fired_upon?
  end

  def test_it_can_display_result
    player_board = Board.new
    computer_board = Board.new
    submarine = Ship.new("Submarine", 2)
    computer_board.place(submarine, ["B1", "B2"])
    turn = Turn.new(player_board, computer_board)

    turn.player_shot("A1")
    miss_message = "Your shot on A1 missed."

    assert_equal miss_message, turn.display_result("A1")

    turn.player_shot("B1")
    hit_message = "Your shot on B1 hit a ship."

    assert_equal hit_message, turn.display_result("B1")

    turn.player_shot("B2")
    sink_message = "Your shot on B2 sunk a ship."

    assert_equal sink_message, turn.display_result("B2")
  end
end

=begin
Computer chooses a random shot (some condition where we win first)
  cells.keys.sample unless cell.fired_upon?

show message of the outcome of firing
display_boards
=end

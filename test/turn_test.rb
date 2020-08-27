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

end

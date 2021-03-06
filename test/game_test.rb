require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/turn'
require './lib/game'

class GameTest < Minitest::Test

  def test_it_exists
    game = Game.new

    assert_instance_of Game, game
  end

  def test_it_has_a_two_boards
    game = Game.new

    assert_instance_of Board, game.player_board
    assert_instance_of Board, game.computer_board
  end

  def test_it_makes_a_computer_board
    game = Game.new

    game.setup_computer_board

    cells_with_a_ship = []
    game.computer_board.cells.each do |coordinate, cell|
      if !cell.empty?
        cells_with_a_ship << cell
      end
    end

    actual = cells_with_a_ship.length

    assert_equal 5, actual
  end

  def test_it_makes_a_player_board
    skip
    game = Game.new

    game.setup_player_board

    cells_with_a_ship = []
    game.player_board.cells.each do |coordinate, cell|
      if !cell.empty?
        cells_with_a_ship << cell
      end
    end

    actual = cells_with_a_ship.length

    assert_equal 5, actual
  end

  def test_it_can_be_game_over
    game = Game.new

    refute game.game_over?

    3.times do
      game.computer_ships[0].hit
    end

    2.times do
      game.computer_ships[1].hit
    end

    assert game.game_over?
  end
end

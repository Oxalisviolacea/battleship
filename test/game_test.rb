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

end

=begin
- start
 call every method

- Show main menu
     play or quit
     if play, then start game

- make_computer_board
    computer is placing ships randomly
    iterate through cells.keys then board.place (some randomness)

- make_player_board
    user is prompted to place ships
    valid coordinate?
    valid placement?
    if not those things, show error and re-prompt

- turn_loop
      turn methods
        computer shot
        player shot
      board update
      until has_lost?

- game_ending(winner)
    if its ended show winner and final boards
      then return to the main menu again
=end

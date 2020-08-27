=begin
  Show main menu
    play or quit

  if play, then start game

  in start

    set up
      computer is placing ships randomly
      iterate through cells.keys then board.place (some randomness)

      user is prompted to place ships
        valid coordinate?
        valid placement?
        if not those things, show error and re-prompt

    play a turn (this should loop somehow until game is over/won?)
      turn methods
      computer shot
      player shot
      board update

  game ending
    check user or computer ships are all sunk?
    if its ended show winner and final boards
      then return to the main menu again


   start
    set_up
    play
    game_ending
  end 
=end

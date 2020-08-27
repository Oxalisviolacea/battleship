class Turn
  attr_reader :player_board, :computer_board

  def initialize(player_board, computer_board)
    @player_board = player_board
    @computer_board = computer_board
  end

  def display_boards
    "=============COMPUTER BOARD=============\n" +
    computer_board.render +
    "==============PLAYER BOARD==============\n" +
    player_board.render(true)
  end

end

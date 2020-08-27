class Game
  attr_reader :player_board, :computer_board
  
  def initialize
    @player_board = Board.new
    @computer_board = Board.new
  end

end

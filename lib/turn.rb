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

  def take_player_input
    puts "Enter the coordinate for your shot:"
    coordinate = gets.chomp.upcase
    until player_board.valid_coordinate?(coordinate)
      puts "Please enter a valid coordinate:"
      coordinate = gets.chomp.upcase
    end
    player_shot(coordinate)
  end

  def player_shot(coordinate)
    @computer_board.cells[coordinate].fire_upon
    display_result(coordinate)
  end

  def display_result(coordinate)
    if @computer_board.cells[coordinate].render == "X"
      "Your shot on #{coordinate} sunk a ship."
    elsif @computer_board.cells[coordinate].render == "H"
      "Your shot on #{coordinate} hit a ship."
    elsif @computer_board.cells[coordinate].render == "M"
      "Your shot on #{coordinate} missed."
    end
  end

  def computer_shot
    player_board.cells.keys.sample 
  end
end

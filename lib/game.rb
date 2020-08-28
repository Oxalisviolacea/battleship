class Game
  attr_reader :player_board, :computer_board

  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
  end

  def welcome
    user_input = ""
    until user_input == "q"
     puts "Welcome to BATTLESHIP\n
     Enter p to play. Enter q to quit."
     user_input = gets.chomp.downcase
     if user_input == "p"
       start
     else
       puts "Alright, maybe next time."
     end
    end
  end

  def start
    setup_computer_board
    setup_player_board
    play
  end

  def setup_computer_board
    #randomly place cruiser
    loop do
      random_coordinates = []

      until random_coordinates.count == @computer_cruiser.length
        random_coordinates << @computer_board.cells.keys.sample
      end

      if @computer_board.valid_placement?(@computer_cruiser, random_coordinates)
        @computer_board.place(@computer_cruiser, random_coordinates)
        break
      end
    end

    #randomly place submarine
    loop do
      random_coordinates = []

      until random_coordinates.count == @computer_submarine.length
        random_coordinates << @computer_board.cells.keys.sample
      end

      if @computer_board.valid_placement?(@computer_submarine, random_coordinates)
        @computer_board.place(@computer_submarine, random_coordinates)
        break
      end
    end
  end

  def setup_player_board
    #place cruiser
    puts setup_player_board_message(@player_cruiser)

    loop do
      player_coordinates = gets.chomp.upcase.split(" ")


      if @player_board.valid_placement?(@player_cruiser, player_coordinates)
        @player_board.place(@player_cruiser, player_coordinates)
        break
      end

      puts "Those are invalid coordinates. Please try again:"
    end

    #place submarine
    puts setup_player_board_message(@player_submarine)

    loop do
      player_coordinates = gets.chomp.upcase.split(" ")


      if @player_board.valid_placement?(@player_submarine, player_coordinates)
        @player_board.place(@player_submarine, player_coordinates)
        break
      end

      puts "Those are invalid coordinates. Please try again:"
    end
  end

  def setup_player_board_message(ship)
    "I have laid out my ships on the grid.\n" +
    "You now need to lay out your two ships.\n" +
    "The Cruiser is three units long and the Submarine is two units long.\n" +
    player_board.render(true) +
    "Enter the squares for the #{ship.name} (#{ship.length} spaces):\n"
  end

  def play
    turn = Turn.new(player_board, computer_board)
    puts turn.display_boards
    until game_over?
     turn.take_player_input
     turn.computer_shot
     puts turn.display_boards
    end
  end

  def game_over?
    if @computer_cruiser.sunk? && @computer_submarine.sunk?
      puts "You won!"
      return true
    elsif @player_cruiser.sunk? && @player_submarine.sunk?
      puts "I won!"
      return true
    end
    false
  end
end

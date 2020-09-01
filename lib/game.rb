class Game
  attr_reader :player_board, :computer_board

  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @player_ships = [
      Ship.new("Cruiser", 3),
      Ship.new("Submarine", 2)
      ]
    @computer_ships = [
      Ship.new("Cruiser", 3),
      Ship.new("Submarine", 2)
      ]
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
    create_custom_board
    create_custom_ship
    setup_computer_board
    setup_player_board
    play
  end

  def create_custom_board
    puts "A default board is 4 cells by 4 cells."
    puts "Would you like to create a custom board? Yes or No"
    user_input = gets.chomp.capitalize
    if user_input == "Yes"
      puts "What is the board's width?:"
      width = gets.chomp.to_i
      until width > 2
        puts "Please enter a width greater than 2:"
        width = gets.chomp.to_i
      end

      puts "What is the board's height?:"
      height = gets.chomp.to_i
      until height > 2
        puts "Please enter a height greater than 2:"
        height = gets.chomp.to_i
      end

      @player_board = Board.new(width, height)
      @computer_board = Board.new(width, height)
    else
      @player_board = Board.new
      @computer_board = Board.new
    end
  end

  def create_custom_ship
    custom_ship_response = ""
    loop do
      puts "Would you like to create a custom ship? Yes or No"
      custom_ship_response = gets.chomp.capitalize
      break if custom_ship_response == "No"
      puts "What's ship's the name?"
      name = gets.chomp
      puts "What's the ship's length?"
      length = gets.chomp.to_i

      custom_player_ship = Ship.new(name, length)
      custom_computer_ship = Ship.new(name, length)
      @player_ships << custom_player_ship
      @computer_ships << custom_computer_ship
    end
  end

  def setup_computer_board
    @computer_ships.each do |ship|
      loop do
        random_coordinates = []

        until random_coordinates.count == ship.length
          random_coordinates << @computer_board.cells.keys.sample
        end

        if @computer_board.valid_placement?(ship, random_coordinates)
          @computer_board.place(ship, random_coordinates)
          break
        end
      end
    end
  end

  def setup_player_board_message(ship)
    "I have laid out my #{ship.name} on the grid.\n" +
    "You now need to lay out your #{ship.name}.\n" +
    "The #{ship.name} is #{ship.length} units long.\n" +
    player_board.render(true) +
    "Enter the square(s) for the #{ship.name} (#{ship.length} spaces):\n"
  end

  def setup_player_board
    @player_ships.each do |ship|
      puts setup_player_board_message(ship)

      loop do
        player_coordinates = gets.chomp.upcase.split(" ")

        if @player_board.valid_placement?(ship, player_coordinates)
         @player_board.place(ship, player_coordinates)
         break
        end

        puts "Those are invalid coordinates. Please try again:"
      end
    end
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
    if @computer_ships.all? {|ship| ship.sunk?}
      puts "You won!"
      return true
    elsif @player_ships.all? {|ship| ship.sunk?}
      puts "I won!"
      return true
    end
    false
  end
end

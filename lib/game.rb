class Game
  attr_reader :player_board, :computer_board

  def initialize
    @player_board = Board.new
    @computer_board = Board.new
  end

  def setup_computer_board
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    #randomly place cruiser
    loop do
      random_coordinates = []

      until random_coordinates.count == cruiser.length
        random_coordinates << @computer_board.cells.keys.sample
      end

      if @computer_board.valid_placement?(cruiser, random_coordinates)
        @computer_board.place(cruiser, random_coordinates)
        break
      end
    end

    #randomly place submarine
    loop do
      random_coordinates = []

      until random_coordinates.count == submarine.length
        random_coordinates << @computer_board.cells.keys.sample
      end

      if @computer_board.valid_placement?(submarine, random_coordinates)
        @computer_board.place(submarine, random_coordinates)
        break
      end
    end
  end

  def setup_player_board
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    #place cruiser
    puts setup_player_board_message(cruiser)

    loop do
      player_coordinates = gets.chomp.upcase.split(" ")


      if @player_board.valid_placement?(cruiser, player_coordinates)
        @player_board.place(cruiser, player_coordinates)
        break
      end

      puts "Those are invalid coordinates. Please try again:"
    end

    #place submarine
    puts setup_player_board_message(submarine)

    loop do
      player_coordinates = gets.chomp.upcase.split(" ")


      if @player_board.valid_placement?(submarine, player_coordinates)
        @player_board.place(submarine, player_coordinates)
        break
      end

      puts "Those are invalid coordinates. Please try again:"
    end
  end

  def setup_player_board_message(ship)
    "I have laid out my ships on the grid.
    You now need to lay out your two ships.
    The Cruiser is three units long and the Submarine is two units long.
    #{player_board.render(true)}
    Enter the squares for the #{ship.name} (#{ship.length} spaces):"
  end

end

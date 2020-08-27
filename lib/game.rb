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
        require "pry"; binding.pry
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

end

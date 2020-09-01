class Board
  attr_reader :cells

  def initialize(width = 4, height = 4)
    @cells = generate_board(width, height)
    @width = width
    @height = height
  end

  def generate_board(width, height)
    columns = (1..width).to_a
    rows = ["A"]

    (height - 1).times do
      rows << rows.last.succ
    end

    board = {}
    rows.each do |letter|
      columns.each do |number|
        board[letter + number.to_s] = Cell.new(letter + number.to_s)
      end
    end
    board
  end

  def valid_coordinate?(coordinate)
    cells.has_key?(coordinate) && !cells[coordinate].fired_upon?
  end

  def valid_placement?(ship, coordinates)
    valid_length?(ship, coordinates) &&
    no_diagonals?(ship, coordinates) &&
    consecutive?(ship, coordinates) &&
    !overlapping?(ship, coordinates)
  end

  def valid_length?(ship, coordinates)
    ship.length == coordinates.length
  end

  def no_diagonals?(ship, coordinates)
    first = coordinates.map do |coordinate|
      coordinate[0]
    end

    second = coordinates.map do |coordinate|
      coordinate[1]
    end

    second.uniq.length == 1 || first.uniq.length == 1
  end

  def consecutive?(ship, coordinates)
    first_chars = coordinates.map do |coordinate|
      coordinate[0]
    end

    second_chars = coordinates.map do |coordinate|
      coordinate[1].to_i
    end

    consecutive_letters = []
    ('A'..'D').each_cons(ship.length) do |letter|
      consecutive_letters << letter
    end

    consecutive_numbers = []
    (1..4).each_cons(ship.length) do |number|
      consecutive_numbers << number
    end

    consecutive_letters.include?(first_chars) || consecutive_numbers.include?(second_chars)
  end

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end
  end

  def overlapping?(ship, coordinates)
    coordinates.find do |coordinate|
      if !cells[coordinate].empty?
        return true
      end
    end
  end

  def render(show = false)
     board =  "  1 2 3 4 \n" +
              "A A1 A2 A3 A4 \n" +
              "B B1 B2 B3 B4 \n" +
              "C C1 C2 C3 C4 \n" +
              "D D1 D2 D3 D4 \n"

    cells.map do |coordinate, cell|
       board.sub!(coordinate, cell.render(show))
    end
    board
  end
end

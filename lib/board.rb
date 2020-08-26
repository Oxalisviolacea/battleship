class Board
  attr_reader :cells

  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
      }
  end

  def valid_coordinate?(coordinate)
    cells.has_key?(coordinate)
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
    overlap = false
    coordinates.each do |coordinate|
      if !cells[coordinate].empty?
        overlap = true
      end
    end
    overlap
  end

  def render(show = false)
     board =  "  1 2 3 4 \n" +
              "A . . . . \n" +
              "B . . . . \n" +
              "C . . . . \n" +
              "D . . . . \n"

    cells.map do |coordinate, cell|
       board.sub!(".", cell.render(show))
    end
    board
  end
end

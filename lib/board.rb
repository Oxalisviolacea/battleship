class Board
  attr_reader :cells, :width, :height

  def initialize(width = 4, height = 4)
    @width = width
    @height = height
    @cells = generate_board
  end

  def rows
    letters = ["A"]
    (height - 1).times do
      letters << letters.last.succ
    end
    letters
  end

  def columns
    (1..width).to_a.map do |number|
      number.to_s
    end
  end

  def generate_board
    board = {}
    rows.each do |letter|
      columns.each do |number|
        board[letter + number] = Cell.new(letter + number)
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
    letters = coordinates.map do |coordinate|
      coordinate.delete("^A-Z")
    end

    numbers = coordinates.map do |coordinate|
      coordinate.delete("^0-9")
    end

    letters.uniq.length == 1 || numbers.uniq.length == 1
  end

  def consecutive?(ship, coordinates)
    letters = coordinates.map do |coordinate|
      coordinate.delete("^A-Z")
    end

    numbers = coordinates.map do |coordinate|
      coordinate.delete("^0-9")
    end

    consecutive_letters = []
    rows.each_cons(ship.length) do |letter|
      consecutive_letters << letter
    end

    consecutive_numbers = []
    columns.each_cons(ship.length) do |number|
      consecutive_numbers << number
    end

    consecutive_letters.include?(letters) || consecutive_numbers.include?(numbers)
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
    first_row = "  " + columns.join(" ") + " \n"
    next_rows = rows.map do |letter|
                  coordinates = columns.map do |number|
                                  "#{letter + number}"
                                end
                  letter + " " + coordinates.join(" ") + " \n"
                end
    board = first_row + next_rows.join

    cells.map do |coordinate, cell|
       board.sub!(coordinate, cell.render(show))
    end
    board
  end
end

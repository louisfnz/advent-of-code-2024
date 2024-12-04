class Day4
  DIRECTIONS = [
    [0, 1],
    [0, -1],
    [-1, 0],
    [1, 0],
    [-1, 1],
    [-1, -1],
    [1, 1],
    [1, -1]
  ]

  def parse_grid(input)
    input.split("\n").map { |line| line.split("") }
  end

  def has_char?(y, x, char)
    return false if y < 0 || y >= @grid.length
    return false if x < 0 || x >= @grid[y].length

    @grid[y][x] == char
  end

  def found_xmas?(dir, y, x)
    xmas = 'XMAS'

    xmas.length.times do |i|
      dy = y + (dir[0] * i)
      dx = x + (dir[1] * i)

      return false unless has_char?(dy, dx, xmas[i])
    end

    true
  end

  def found_x?(y, x)
    return false if @grid[y][x] != 'A'

    check_1 = has_char?(y - 1, x - 1, 'M') && has_char?(y + 1, x + 1, 'S')
    check_2 = has_char?(y - 1, x - 1, 'S') && has_char?(y + 1, x + 1, 'M')
    return false unless check_1 || check_2

    check_1 = has_char?(y - 1, x + 1, 'M') && has_char?(y + 1, x - 1, 'S')
    check_2 = has_char?(y - 1, x + 1, 'S') && has_char?(y + 1, x - 1, 'M')
    check_1 || check_2
  end

  def grid_loop
    @grid.length.times do |y|
      @grid[y].length.times do |x|
        yield(y, x)
      end
    end
  end

  def part1(input)
    @grid = parse_grid(input)

    total = 0

    grid_loop do |y, x|
      DIRECTIONS.each do |dir|
        total += 1 if found_xmas?(dir, y, x)
      end
    end

    total
  end

  def part2(input)
    @grid = parse_grid(input)

    total = 0

    grid_loop do |y, x|
      total += 1 if found_x?(y, x)
    end

    total
  end
end

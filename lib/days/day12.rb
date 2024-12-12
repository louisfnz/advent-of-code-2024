class Day12
  DIRECTIONS = [[-1, 0], [0, 1], [1, 0], [0, -1]]

  def parse_grid(input)
    input.split("\n").map(&:chars)
  end

  def key(x, y)
    [x, y].join(',')
  end

  def count_corners(letter, x, y)
    corners = 0
    if y - 1 >= 0 && x - 1 >= 0 && @grid[y - 1][x - 1] != letter && @grid[y - 1][x] == letter && @grid[y][x - 1] == letter
      corners += 1
    end
    if y - 1 >= 0 && x + 1 < @grid[0].length && @grid[y - 1][x + 1] != letter && @grid[y - 1][x] == letter && @grid[y][x + 1] == letter
      corners += 1
    end
    if y + 1 < @grid.length && x + 1 < @grid[0].length && @grid[y + 1][x + 1] != letter && @grid[y + 1][x] == letter && @grid[y][x + 1] == letter
      corners += 1
    end
    if y + 1 < @grid.length && x - 1 >= 0 && @grid[y + 1][x - 1] != letter && @grid[y + 1][x] == letter && @grid[y][x - 1] == letter
      corners += 1
    end

    if y - 1 < 0 || @grid[y - 1][x] != letter
      if x - 1 < 0 || @grid[y][x - 1] != letter
        corners += 1
      end
      if x + 1 >= @grid[0].length || @grid[y][x + 1] != letter
        corners += 1
      end
    end
    if y + 1 >= @grid.length || @grid[y + 1][x] != letter
      if x - 1 < 0 || @grid[y][x - 1] != letter
        corners += 1
      end
      if x + 1 >= @grid[0].length || @grid[y][x + 1] != letter
        corners += 1
      end
    end
    corners
  end

  def get_region_data(letter, start_row, start_col)
    rows = @grid.length
    cols = @grid[0].length
    area = 0
    perimeter = 0
    corners = 0
    stack = [[start_row, start_col]]

    until stack.empty?
      row, col = stack.pop
      next if @visited.include?(key(col, row))
      next if row < 0 || row >= rows || col < 0 || col >= cols
      next if @grid[row][col] != letter

      @visited.add(key(col, row))
      area += 1

      corners += count_corners(letter, col, row)

      DIRECTIONS.each do |dx, dy|
        new_row = row + dx
        new_col = col + dy

        if new_row < 0 || new_row >= rows || new_col < 0 || new_col >= cols || @grid[new_row][new_col] != letter
          perimeter += 1
        else
          stack.push([new_row, new_col])
        end
      end
    end

    [area, perimeter, corners]
  end

  def process_grid(input)
    @grid = parse_grid(input)
    @visited = Set.new

    total_perimeter = 0
    total_sides = 0

    @grid.length.times do |y|
      @grid[0].length.times do |x|
        unless @visited.include?(key(x, y))
          area, perimeter, sides = get_region_data(@grid[y][x], y, x)
          total_perimeter += area * perimeter
          total_sides += area * sides
        end
      end
    end

    [total_perimeter, total_sides]
  end

  def part1(input)
    perimeter, = process_grid(input)
    perimeter
  end

  def part2(input)
    _, sides = process_grid(input)
    sides
  end
end

class Day12
  def parse_grid(input)
    input.split("\n").map(&:chars)
  end

  def key(x, y)
    [x, y].join(',')
  end

  def find_region_perimeter(letter, start_row = nil, start_col = nil)
    rows = @grid.length
    cols = @grid[0].length

    if start_row.nil? || start_col.nil?
      @grid.each_with_index do |row, r|
        row.each_with_index do |cell, c|
          if cell == letter && !@visited.include?(key(c, r))
            start_row = r
            start_col = c
            break
          end
        end
      end
    end

    area = 0
    perimeter = 0
    stack = [[start_row, start_col]]

    directions = [[-1, 0], [0, 1], [1, 0], [0, -1]]

    until stack.empty?
      row, col = stack.pop
      next if row < 0 || row >= rows || col < 0 || col >= cols
      next if @visited.include?(key(col, row))
      next if @grid[row][col] != letter

      @visited.add(key(col, row))
      area += 1

      directions.each do |dx, dy|
        new_row = row + dx
        new_col = col + dy

        if new_row < 0 || new_row >= rows || new_col < 0 || new_col >= cols || @grid[new_row][new_col] != letter
          perimeter += 1
        else
          stack.push([new_row, new_col])
        end
      end
    end

    [area, perimeter]
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

  def find_region_sides(letter, start_row, start_col)
    rows = @grid.length
    cols = @grid[0].length

    area = 0
    directions = [[-1, 0], [0, 1], [1, 0], [0, -1]]
    stack = [[start_row, start_col]]
    corners = 0

    until stack.empty?
      row, col = stack.pop
      next if @visited.include?(key(col, row))
      next if row < 0 || row >= rows || col < 0 || col >= cols
      next if @grid[row][col] != letter

      @visited.add(key(col, row))
      area += 1

      corners += count_corners(letter, col, row)

      directions.each do |dx, dy|
        new_row = row + dx
        new_col = col + dy

        if new_row < 0 || new_row >= rows || new_col < 0 || new_col >= cols || @grid[new_row][new_col] != letter
        else
          stack.push([new_row, new_col])
        end
      end
    end

    [area, corners]
  end

  def part1(input)
    @grid = parse_grid(input)
    @visited = Set.new

    total = 0

    @grid.length.times do |y|
      @grid[0].length.times do |x|
        unless @visited.include?(key(x, y))
          area, perimeter = find_region_perimeter(@grid[y][x], y, x)
          total += area * perimeter
        end
      end
    end

    total
  end

  def part2(input)
    @grid = parse_grid(input)
    @visited = Set.new

    total = 0

    @grid.length.times do |y|
      @grid[0].length.times do |x|
        unless @visited.include?(key(x, y))
          area, sides = find_region_sides(@grid[y][x], y, x)
          total += area * sides
        end
      end
    end

    total
  end
end

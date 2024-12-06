class Day6
  DIRECTIONS = {
    'U' => [0, -1],
    'D' => [0, 1],
    'L' => [-1, 0],
    'R' => [1, 0]
  }

  NEXT_DIRECTION = {
    'U' => 'R',
    'R' => 'D',
    'D' => 'L',
    'L' => 'U'
  }

  def parse_grid(input)
    input.split("\n").map { |line| line.split("") }
  end

  def out_of_bounds?(x, y)
    x < 0 || x >= @grid[0].length || y < 0 || y >= @grid.length
  end

  def start_pos
    @grid.length.times do |y|
      @grid[y].length.times do |x|
        return [x, y] if @grid[y][x] == '^'
      end
    end
  end

  def visited_positions
    dir = 'U'
    current = start_pos
    visited = Set.new([current.join(",")])

    while true
      vector = DIRECTIONS[dir]
      nx, ny = current[0] + vector[0], current[1] + vector[1]

      break if out_of_bounds?(nx, ny)

      if @grid[ny][nx] == '#'
        dir = NEXT_DIRECTION[dir]
        next
      end

      visited.add([nx, ny].join(","))
      current = [nx, ny]
    end

    visited
  end

  def has_loop?(grid, start)
    dir = 'U'
    current = start
    visited = Set.new([(['U'] + current).join(",")])

    while true
      vector = DIRECTIONS[dir]
      nx, ny = current[0] + vector[0], current[1] + vector[1]
      key = ([dir] + [nx, ny]).join(",")

      return true if visited.include?(key)

      break if out_of_bounds?(nx, ny)

      if grid[ny][nx] == '#'
        dir = NEXT_DIRECTION[dir]
        next
      end

      visited.add(key)
      current = [nx, ny]
    end

    false
  end

  def part1(input)
    @grid = parse_grid(input)

    visited_positions.length
  end

  def part2(input)
    @grid = parse_grid(input)

    start = start_pos
    locations = visited_positions
    locations.delete(start.join(","))

    locations.reduce(0) do |total, pos|
      obstacle = pos.split(",").map(&:to_i)
      new_grid = @grid.map(&:dup)
      new_grid[obstacle[1]][obstacle[0]] = '#'

      total += 1 if has_loop?(new_grid, start)
      total
    end
  end
end

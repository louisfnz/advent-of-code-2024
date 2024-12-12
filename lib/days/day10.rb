class Day10
  DIRECTIONS = [
    [-1, 0],
    [1, 0],
    [0, -1],
    [0, 1],
  ]

  def parse_grid(input)
    input.split("\n").map { |line| line.split('').map(&:to_i) }
  end

  def out_of_bounds?(x, y)
    x < 0 || y < 0 || x >= @grid[0].length || y >= @grid.length
  end

  def search(x, y, current, start_key, visited = nil)
    @answers[start_key] = 0 if current == 0
    return if current == 9

    DIRECTIONS.each do |dx, dy|
      nx = x + dx
      ny = y + dy

      check = visited ? visited.include?([nx, ny].join(",")) : false

      next if out_of_bounds?(nx, ny)

      if @grid[ny][nx] == current + 1 && !check
        visited.add([nx, ny].join(",")) if visited
        if current == 8
          @answers[start_key] = @answers[start_key] + 1
        else
          search(nx, ny, current + 1, start_key, visited)
        end
      end
    end
  end

  def part1(input)
    @grid = parse_grid(input)
    @answers = {}

    @grid.length.times do |y|
      @grid[y].length.times do |x|
        next unless @grid[y][x] == 0

        search(x, y, 0, [x, y].join(","), Set.new([[x, y].join(",")]))
      end
    end

    @answers.reduce(0) do |total, (key, value)|
      total + value
    end
  end

  def part2(input)
    @grid = parse_grid(input)
    @answers = {}

    @grid.length.times do |y|
      @grid[y].length.times do |x|
        next unless @grid[y][x] == 0

        search(x, y, 0, [x, y].join(","))
      end
    end

    @answers.reduce(0) do |total, (key, value)|
      total + value
    end
  end
end

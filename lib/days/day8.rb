class Day8
  def parse_grid(input)
    input.split("\n").map { |line| line.split("") }
  end

  def node_groups
    result = {}

    @grid.length.times do |y|
      @grid[y].length.times do |x|
        node = @grid[y][x]
        next if node == "."

        result[node] ||= []
        result[node] << [x, y]
      end
    end

    result
  end

  def rotate_point(point, center)
    x = 2 * center[0] - point[0]
    y = 2 * center[1] - point[1]

    if x >= 0 && x < @grid[0].length && y >= 0 && y < @grid.length
      [x, y]
    end
  end

  def part1(input)
    @grid = parse_grid(input)
    groups = node_groups
    antinodes = Set.new

    groups.each do |node, coords|
      pairs = coords.combination(2).to_a

      pairs.each do |pair|
        rotated1 = rotate_point(pair[0], pair[1])
        rotated2 = rotate_point(pair[1], pair[0])

        antinodes.add(rotated1.join(",")) if rotated1
        antinodes.add(rotated2.join(",")) if rotated2
      end
    end

    antinodes.length
  end

  def part2(input)
    @grid = parse_grid(input)
    groups = node_groups
    antinodes = Set.new

    groups.each do |node, coords|
      pairs = coords.combination(2).to_a

      pairs.each do |pair|
        antinodes.add(pair[0].join(","))
        antinodes.add(pair[1].join(","))

        [[0, 1], [1, 0]].each do |a, b|
          point = pair[a]
          pivot = pair[b]

          while (rotated = rotate_point(point, pivot))
            antinodes.add(rotated.join(","))
            point, pivot = pivot, rotated
          end
        end
      end
    end

    antinodes.length
  end
end

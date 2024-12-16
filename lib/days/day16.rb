class Day16
  DIRECTIONS = {
    'N' => [0, -1],
    'E' => [1, 0],
    'S' => [0, 1],
    'W' => [-1, 0]
  }

  DIRECTION_ARROWS = {
    'N' => '^',
    'E' => '>',
    'S' => 'v',
    'W' => '<'
  }

  def parse_input(input)
    input.split("\n").map do |line|
      line.split('')
    end
  end

  def print_map(map)
    map.each do |row|
      str = row.map do |cell|
        case cell
        when '>','<','^','v'
          Rainbow(cell).bold
        when 'S'
          Rainbow(cell).green.bold
        when 'E'
          Rainbow(cell).red.bold
        when '.'
          Rainbow(cell).black
        else
          Rainbow(cell).white
        end
      end
      puts str.join('')
    end
  end

  def print_path(path)
    map = @map.map(&:dup)
    path.each do |x, y, dir|
      map[y][x] = DIRECTION_ARROWS[dir] unless %w[S E].include? map[y][x]
    end
    print_map(map)
  end

  def get_start_position
    @map.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        return [x, y] if cell == 'S'
      end
    end
  end

  def is_end?(x, y)
    @map[y][x] == 'E'
  end

  def is_blocked?(x, y)
    @map[y][x] == '#'
  end

  def opposite_dir(dir)
    case dir
    when 'N'
      'S'
    when 'S'
      'N'
    when 'E'
      'W'
    when 'W'
      'E'
    end
  end

  def reindeer_games(input)
    @map = parse_input(input)
    start_position = get_start_position
    dir = 'E'
    score_map = {}
    paths = []

    min_score = nil

    queue = [[start_position, dir, 0, []]]

    until queue.empty?
      pos, dir, score, path = queue.shift
      x, y = pos
      path << [x, y, dir]

      if is_end?(x, y)
        if min_score.nil? || score < min_score
          paths = []
          min_score = score
        end
        paths << path if score == min_score
        next
      end

      score_key = [x, y, dir].join(',')
      next if score_map[score_key] && score_map[score_key] < score

      score_map[score_key] = score
      next if min_score && score > min_score

      DIRECTIONS.each do |new_dir, (dx, dy)|
        next if new_dir == opposite_dir(dir)

        new_x = x + dx
        new_y = y + dy
        next if is_blocked?(new_x, new_y)

        queue << [
          [new_x, new_y],
          new_dir,
          score + (dir != new_dir ? 1001 : 1),
          path.dup
        ]
      end
    end

    [min_score, paths]
  end

  def part1(input)
    min_score, _ = reindeer_games(input)
    min_score
  end

  def part2(input)
    _, paths = reindeer_games(input)

    paths.reduce(Set.new) do |shared_tiles, path|
      shared_tiles + path.map { |x, y| [x, y] }
    end.size
  end
end

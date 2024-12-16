class Day15
  DIRECTIONS = {
    '^' => [0, -1],
    'v' => [0, 1],
    '<' => [-1, 0],
    '>' => [1, 0]
  }

  def parse_input(input)
    grid, instructions = input.split("\n\n")

    instructions = instructions.split("\n").reduce([]) do |acc, line|
      acc.concat(line.split(''))
    end

    grid = grid.split("\n").map do |line|
      line.split('')
    end

    [grid, instructions]
  end

  def start_position
    @grid.length.times do |y|
      @grid[y].length.times do |x|
        return [x, y] if @grid[y][x] == '@'
      end
    end
  end

  def print_grid
    @grid.each do |row|
      puts row.join('')
    end
  end

  def move(current, dir)
    to_move = []
    vector = DIRECTIONS[dir]
    check_pos = Set.new([[current[0] + vector[0], current[1] + vector[1]]])

    while true
      cancel = false
      all_empty = true
      new_check_pos = Set.new
      new_move = Set.new

      check_pos.each do |pos|
        char = @grid[pos[1]][pos[0]]

        if char == '#'
          cancel = true
          break
        end

        if %w([ ] O).include?(char)
          all_empty = false
          new_check_pos.add([pos[0] + vector[0], pos[1] + vector[1]])
          new_move.add([pos[0], pos[1]])

          if %w[^ v].include?(dir)
            if char == '['
              new_check_pos.add([pos[0] + vector[0] + 1, pos[1] + vector[1]])
              new_move.add([pos[0] + 1, pos[1]])
            end
            if char == ']'
              new_check_pos.add([pos[0] + vector[0] - 1, pos[1] + vector[1]])
              new_move.add([pos[0] - 1, pos[1]])
            end
          end
        end
      end

      break if cancel

      to_move << new_move

      if all_empty
        to_move.reverse.each_with_index do |pos_set, i|
          pos_set.to_a.each_with_index do |pos, j|
            char = @grid[pos[1]][pos[0]]
            @grid[pos[1]][pos[0]] = '.'
            @grid[pos[1] + vector[1]][pos[0] + vector[0]] = char
          end
        end
        @grid[current[1]][current[0]] = '.'
        current = [current[0] + vector[0], current[1] + vector[1]]
        @grid[current[1]][current[0]] = '@'
        return current
      end

      check_pos = new_check_pos
    end

    current
  end

  def gps_sum
    total = 0
    @grid.length.times do |y|
      @grid[y].length.times do |x|
        total += 100 * y + x if %w(O [).include?(@grid[y][x])
      end
    end
    total
  end

  def scale_grid
    new_grid = []
    @grid.each do |row|
      new_row = []
      row.each do |cell|
        if cell == '#' || cell == '.'
          new_row << cell
          new_row << cell
        end
        if cell == '@'
          new_row << cell
          new_row << '.'
        end
        if cell == 'O'
          new_row << '['
          new_row << ']'
        end
      end
      new_grid << new_row
    end
    @grid = new_grid
  end

  def run_moves
    current = start_position

    while @instructions.length > 0
      dir = @instructions.shift
      current = move(current, dir)
    end

    gps_sum
  end

  def part1(input)
    @grid, @instructions = parse_input(input)
    run_moves
  end

  def part2(input)
    @grid, @instructions = parse_input(input)
    scale_grid
    run_moves
  end
end

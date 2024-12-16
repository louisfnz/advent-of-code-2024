class Day14
  def parse_input(input)
    lines = input.split("\n")
    lines.map do |line|
      parts = line.match(/p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)/)
      {
        p: [parts[1].to_i, parts[2].to_i],
        v: [parts[3].to_i, parts[4].to_i]
      }
    end
  end

  def move_robot(robot)
    robot[:p][0] = (robot[:p][0] + robot[:v][0]) % @dims[0]
    robot[:p][1] = (robot[:p][1] + robot[:v][1]) % @dims[1]

    @grid[robot[:p][1]][robot[:p][0]] = '#' if @grid

    robot
  end

  def quadrant_count(robots)
    q1 = 0
    q2 = 0
    q3 = 0
    q4 = 0

    mid_x = (@dims[0] / 2).floor
    mid_y = (@dims[1] / 2).floor

    robots.each do |robot|
      if robot[:p][0] < mid_x && robot[:p][1] < mid_y
        q1 += 1
      elsif robot[:p][0] > mid_x && robot[:p][1] < mid_y
        q2 += 1
      elsif robot[:p][0] < mid_x && robot[:p][1] > mid_y
        q3 += 1
      elsif robot[:p][0] > mid_x && robot[:p][1] > mid_y
        q4 += 1
      end
    end

    q1 * q2 * q3 * q4
  end

  def has_easter_egg?
    @grid.each do |row|
      return true if row.join('').include?('####################')
    end
    false
  end

  def part1(input, test = false)
    robots = parse_input(input)

    @dims = test ? [11, 7] : [101, 103]

    100.times do
      robots.each_with_index do |_, r|
        robots[r] = move_robot(robots[r])
      end
    end

    quadrant_count(robots)
  end

  def part2(input)
    robots = parse_input(input)

    @dims = [101, 103]

    100000.times do |i|
      @grid = Array.new(@dims[1]) { Array.new(@dims[0], '.') }
      robots.each_with_index do |_, r|
        robots[r] = move_robot(robots[r])
      end

      if has_easter_egg?
        return i + 1
      end
    end
  end
end

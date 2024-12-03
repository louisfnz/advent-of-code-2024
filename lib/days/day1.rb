class Day1
  def parse_lists(input, sort = false)
    left = []
    right = []

    input.split("\n").each do |line|
      s = line.split(/\s+/).map(&:to_i)
      left << s[0]
      right << s[1]
    end

    if sort
      left.sort!
      right.sort!
    end

    [left, right]
  end


  def part1(input)
    left, right = parse_lists(input, true)

    left.each_with_index.reduce(0) do |total, (_, i)|
      total + (left[i] - right[i]).abs
    end
  end

  def part2(input)
    left, right = parse_lists(input)

    left.reduce(0) do |total, n|
      total + n * right.count(n)
    end
  end
end

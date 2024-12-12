class Day10Test
  ANSWER_PART1 = 36
  ANSWER_PART2 = 81

  def initialize
    @data = File.read(File.join(ROOT, 'test_input', 'day10.txt')).rstrip
    @day = Day10.new
  end

  def part1
    @day.part1(@data)
  end

  def part2
    @day.part2(@data)
  end
end

class Day9Test
  ANSWER_PART1 = 1928
  ANSWER_PART2 = 2858

  def initialize
    @data = File.read(File.join(ROOT, 'test_input', 'day9.txt')).rstrip
    @day = Day9.new
  end

  def part1
    @day.part1(@data)
  end

  def part2
    @day.part2(@data)
  end
end

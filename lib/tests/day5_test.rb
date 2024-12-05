class Day5Test
  ANSWER_PART1 = 143
  ANSWER_PART2 = 123

  def initialize
    @data = File.read(File.join(ROOT, 'test_input', 'day5.txt')).rstrip
    @day = Day5.new
  end

  def part1
    @day.part1(@data)
  end

  def part2
    @day.part2(@data)
  end
end

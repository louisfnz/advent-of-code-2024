class Day2Test
  ANSWER_PART1 = 2
  ANSWER_PART2 = 4

  def initialize
    @data = File.read(File.join(ROOT, 'test_input', 'day2.txt')).rstrip
    @day = Day2.new
  end

  def part1
    @day.part1(@data)
  end

  def part2
    @day.part2(@data)
  end
end

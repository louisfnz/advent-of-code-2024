class Day1Test
  ANSWER_PART1 = 11
  ANSWER_PART2 = 31

  def initialize
    @data = File.read(File.join(ROOT, 'test_input', 'day1.txt')).rstrip
    @day = Day1.new
  end

  def part1
    @day.part1(@data)
  end

  def part2
    @day.part2(@data)
  end
end

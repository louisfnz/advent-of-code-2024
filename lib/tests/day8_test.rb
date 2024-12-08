class Day8Test
  ANSWER_PART1 = 14
  ANSWER_PART2 = 34

  def initialize
    @data = File.read(File.join(ROOT, 'test_input', 'day8.txt')).rstrip
    @day = Day8.new
  end

  def part1
    @day.part1(@data)
  end

  def part2
    @day.part2(@data)
  end
end

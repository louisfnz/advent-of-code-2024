class Day11Test
  ANSWER_PART1 = 55312
  ANSWER_PART2 = 'invalid'

  def initialize
    @data = File.read(File.join(ROOT, 'test_input', 'day11.txt')).rstrip
    @day = Day11.new
  end

  def part1
    @day.part1(@data)
  end

  def part2
    @day.part2(@data)
  end
end

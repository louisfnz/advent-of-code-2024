class Day6Test
  ANSWER_PART1 = 41
  ANSWER_PART2 = 6

  def initialize
    @data = File.read(File.join(ROOT, 'test_input', 'day6.txt')).rstrip
    @day = Day6.new
  end

  def part1
    @day.part1(@data)
  end

  def part2
    @day.part2(@data)
  end
end

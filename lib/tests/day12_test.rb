class Day12Test
  ANSWER_PART1 = 1930
  ANSWER_PART2 = 1206

  def initialize
    @data = File.read(File.join(ROOT, 'test_input', 'day12.txt')).rstrip
    @day = Day12.new
  end

  def part1
    @day.part1(@data)
  end

  def part2
    @day.part2(@data)
  end
end

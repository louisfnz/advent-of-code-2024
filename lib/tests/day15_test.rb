class Day15Test
  ANSWER_PART1 = 10092
  ANSWER_PART2 = 9021

  def initialize
    @data = File.read(File.join(ROOT, 'test_input', 'day15.txt')).rstrip
    @day = Day15.new
  end

  def part1
    @day.part1(@data)
  end

  def part2
    @day.part2(@data)
  end
end

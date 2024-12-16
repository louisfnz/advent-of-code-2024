class Day16Test
  ANSWER_PART1 = 11048
  ANSWER_PART2 = 64

  def initialize
    @data = File.read(File.join(ROOT, 'test_input', 'day16.txt')).rstrip
    @day = Day16.new
  end

  def part1
    @day.part1(@data)
  end

  def part2
    @day.part2(@data)
  end
end

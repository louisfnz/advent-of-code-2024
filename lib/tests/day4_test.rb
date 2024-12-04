class Day4Test
  ANSWER_PART1 = 18
  ANSWER_PART2 = 9

  def initialize
    @data = File.read(File.join(ROOT, 'test_input', 'day4.txt')).rstrip
    @day = Day4.new
  end

  def part1
    @day.part1(@data)
  end

  def part2
    @day.part2(@data)
  end
end

class Day3Test
  ANSWER_PART1 = 161
  ANSWER_PART2 = 48

  def initialize
    @data_p1 = File.read(File.join(ROOT, 'test_input', 'day3_p1.txt')).rstrip
    @data_p2 = File.read(File.join(ROOT, 'test_input', 'day3_p2.txt')).rstrip
    @day = Day3.new
  end

  def part1
    @day.part1(@data_p1)
  end

  def part2
    @day.part2(@data_p2)
  end
end

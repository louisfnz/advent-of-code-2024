class Day13Test
  ANSWER_PART1 = 480
  ANSWER_PART2 = 875318608908

  def initialize
    @data = File.read(File.join(ROOT, 'test_input', 'day13.txt')).rstrip
    @day = Day13.new
  end

  def part1
    @day.part1(@data)
  end

  def part2
    @day.part2(@data)
  end
end

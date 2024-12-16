class Day14Test
  ANSWER_PART1 = 12
  ANSWER_PART2 = 'N/A'

  def initialize
    @data = File.read(File.join(ROOT, 'test_input', 'day14.txt')).rstrip
    @day = Day14.new
  end

  def part1
    @day.part1(@data, true)
  end

  def part2
    'N/A'
  end
end

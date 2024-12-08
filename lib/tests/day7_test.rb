class Day7Test
  ANSWER_PART1 = 3749
  ANSWER_PART2 = 11387

  def initialize
    @data = File.read(File.join(ROOT, 'test_input', 'day7.txt')).rstrip
    @day = Day7.new
  end

  def part1
    @day.part1(@data)
  end

  def part2
    @day.part2(@data)
  end
end

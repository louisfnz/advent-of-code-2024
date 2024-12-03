class Solve
  def self.day(number)
    exists = File.file?(File.join(ROOT, 'puzzle_input', "day#{number}.txt"))
    unless exists
      Message.error "Puzzle input does not exist! Run `rake download:#{number}`"
      return
    end

    input = File.read(File.join(ROOT, 'puzzle_input', "day#{number}.txt")).rstrip

    klass = Object.const_get("Day#{number.to_s}")
    unless klass
      Message.error "Day#{number} class not implemented!"
      return
    end

    day = klass.new

    p1 = day.part1(input)
    p2 = day.part2(input)

    Message.puzzle_result(1, p1)
    Message.puzzle_result(2, p2)
  end
end

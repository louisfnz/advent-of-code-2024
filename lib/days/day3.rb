class Day3
  def parse_instructions(part, input)
    pattern = part == 1 ? /mul\(\d+,\d+\)/ : /mul\(\d+,\d+\)|do\(\)|don't\(\)/
    input.scan(pattern)
  end

  def multiply(instruction)
    nums = instruction.scan(/\d+/).map(&:to_i)
    nums.reduce(:*)
  end

  def part1(input)
    instructions = parse_instructions(1, input)

    instructions.reduce(0) do |total, instruction|
      total += multiply(instruction)
      total
    end
  end

  def part2(input)
    instructions = parse_instructions(2, input)
    enabled = true

    instructions.reduce(0) do |total, instruction|
      if instruction == "do()"
        enabled = true
        next total
      end

      if instruction == "don't()"
        enabled = false
        next total
      end

      total += multiply(instruction) if enabled
      total
    end
  end
end

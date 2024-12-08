class Day7
  def parse_input(input)
    lines = input.split("\n").map { |line| line.split(":").map(&:strip) }
    lines.reduce([]) do |acc, cur|
      acc << { target: cur[0].to_i, parts: cur[1].split(" ").map { |num| num.strip.to_i } }
    end
  end

  def generate_combinations(numbers, operators)
    return [] if numbers.empty? || numbers.length < 2

    num_slots = numbers.length - 1
    total = operators.length ** num_slots
    results = []

    (0...total).each do |i|
      operator_choices = i.to_s(operators.length).rjust(num_slots, '0')

      expression = []
      expression << numbers[0]

      operator_choices.each_char.with_index do |choice, j|
        operator = operators[choice.to_i]
        expression << operator
        expression << numbers[j + 1]
      end

      results << expression
    end

    results
  end

  def determine_solvable(lines, operators)
    lines.reduce([]) do |acc, line|
      target = line[:target]
      parts = line[:parts]

      combinations = generate_combinations(parts, operators)

      combinations.each do |comb|
        result = comb[0]
        i = 1

        while i < comb.length
          if comb[i] == '+'
            result = result + comb[i + 1]
            i += 2
          elsif comb[i] == '*'
            result = result * comb[i + 1]
            i += 2
          elsif comb[i] == '||'
            result = (result.to_s + comb[i + 1].to_s).to_i
            i += 2
          else
            i += 1
          end
        end

        if result == target
          line[:solvable] = true
          break
        end
      end

      acc << line
    end
  end

  def get_total(lines)
    lines.reduce(0) do |total, line|
      total += line[:target] if line[:solvable]
      total
    end
  end

  def part1(input)
    lines = determine_solvable(parse_input(input), %w[+ *])
    get_total(lines)
  end

  def part2(input)
    lines = determine_solvable(parse_input(input), %w[+ *])
    total = get_total(lines)

    new_lines = determine_solvable(lines.filter { |line| line[:solvable] != true }, %w[+ * ||])
    total + get_total(new_lines)
  end
end

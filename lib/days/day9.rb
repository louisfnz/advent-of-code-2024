class Day9
  def blocks_at(id)
    item = @memory[id * 2]
    item.to_i if item
  end

  def space_at(id)
    item = @memory[id * 2 + 1]
    item.to_i if item
  end

  def calculate_space
    computed = []

    id = 0
    pos = 0
    while (blocks = blocks_at(id)) do
      space = space_at(id)

      blocks.times do
        computed[pos] = id
        pos += 1
      end

      if space
        space.times do
          computed[pos] = nil
          pos += 1
        end
      end

      id += 1
    end

    computed
  end

  def calculate_total(computed)
    total = 0

    computed.each_with_index do |item, i|
      v = item || 0
      total += v * i
    end

    total
  end

  def find_space(computed, block_length, block_index)
    space_index = 0

    while true do
      break if space_index >= block_index
      if computed[space_index] != nil
        space_index += 1
        next
      end

      start = 0
      while true do
        break if computed[space_index + start] != nil
        if start == block_length - 1
          return space_index
        end
        start += 1
      end
      space_index += 1
    end
  end

  def part1(input)
    @memory = input.split('')
    computed = calculate_space

    space = 0
    current = computed.length - 1
    while space < current do
      if computed[current] == nil
        current -= 1
        next
      end

      block = computed.delete_at(current)

      while computed[space] != nil
        space += 1
        break if computed[space] == nil
      end

      computed[space] = block

      space += 1
      current -= 1
    end

    calculate_total(computed)
  end

  def part2(input)
    @memory = input.split('')
    computed = calculate_space

    block_index = computed.length - 1

    while block_index > 0 do
      while computed[block_index] == nil do
        block_index -= 1
      end

      block = computed[block_index]

      block_length = 1

      while true do
        break unless computed[block_index - 1] == block

        block_index -= 1
        block_length += 1
      end

      space_index = find_space(computed, block_length, block_index)

      if space_index
        block_length.times do |i|
          computed[space_index + i] = block
          computed[block_index + i] = nil
        end
      end
      block_index -= 1
    end

    calculate_total(computed)
  end
end

class Day11
  def parse_stones(input)
    stone_map = {}

    input.split(" ").map(&:to_i).each do |stone|
      if stone_map[stone]
        stone_map[stone] += 1
      else
        stone_map[stone] = 1
      end
    end

    stone_map
  end

  def is_even?(stone)
    stone.to_s.length % 2 == 0
  end

  def split_stone(stone)
    stone = stone.to_s
    mid = stone.length / 2
    [stone[0..(mid-1)].to_i, stone[mid..-1].to_i]
  end

  def process_stone(stone)
    if stone == 0
      [1]
    elsif is_even?(stone)
      split_stone(stone)
    else
      [stone * 2024]
    end
  end

  def run_blinks(blinks, stone_map)
    blinks.times do
      new_stone_map = {}
      stone_map.each do |stone, count|
        process_stone(stone).each do |new_stone|
          if new_stone_map[new_stone]
            new_stone_map[new_stone] += count
          else
            new_stone_map[new_stone] = count
          end
        end
      end
      stone_map = new_stone_map
    end

    stone_map
  end

  def part1(input)
    stone_map = parse_stones(input)
    blinks = 25

    run_blinks(blinks, stone_map).reduce(0) do |total, (stone, count)|
      total + count
    end
  end

  def part2(input)
    stone_map = parse_stones(input)
    blinks = 75

    run_blinks(blinks, stone_map).reduce(0) do |total, (stone, count)|
      total + count
    end
  end
end

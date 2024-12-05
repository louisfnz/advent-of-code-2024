class Day5
  def parse_input(input)
    ordering_rules, @pages_to_produce = input.split("\n\n")

    ordering_rules = ordering_rules.split("\n").map { |rule| rule.split('|').map(&:to_i) }
    @pages_to_produce = @pages_to_produce.split("\n").map { |pages| pages.split(',').map(&:to_i) }

    @order_map = {}

    ordering_rules.each do |rule|
      @order_map[rule[0]] ||= {}
      @order_map[rule[0]][rule[1]] = true
    end
  end

  def valid_pages
    @pages_to_produce.filter { |pages| valid?(pages) }
  end

  def invalid_pages
    @pages_to_produce.filter { |pages| !valid?(pages) }
  end

  def valid?(pages)
    pages.each_with_index do |page, i|
      pages.slice(i, pages.length - i).each do |next_page|
        if @order_map[next_page] && @order_map[next_page][page]
          return false
        end
      end
    end

    true
  end

  def middle(pages)
    pages[(pages.length / 2).floor]
  end

  def part1(input)
    parse_input(input)

    valid_pages.reduce(0) do |total, pages|
      total + middle(pages)
    end
  end

  def part2(input)
    parse_input(input)

    corrected_pages = []

    invalid_pages.each_with_index do |pages, p|
      l = 0
      r = 1

      while r < pages.length
        if @order_map[pages[r]] && @order_map[pages[r]][pages[l]]
          pages[l], pages[r] = pages[r], pages[l]
          l = [0, l - 1].max
          r = l + 1
        else
          r += 1
          l += 1
        end
      end

      corrected_pages[p] = pages
    end

    corrected_pages.reduce(0) do |total, pages|
      total + middle(pages)
    end
  end
end

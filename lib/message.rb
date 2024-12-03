class Message
  class << self
    def error(str)
      puts Rainbow(str).red
    end

    def success(str)
      puts Rainbow(str).green
    end

    def text(str)
      puts Rainbow(str).white
    end

    def puzzle_result(part, result)
      puts Rainbow("Part #{part}: ").yellow + Rainbow(result).bright
    end

    def test_success(part, result)
      puts Rainbow("Part #{part}: ").yellow + Rainbow(result).bright + Rainbow(" Correct!").green
    end

    def test_fail(part, result, expected)
      puts Rainbow("Part #{part}: ").yellow + Rainbow(result).bright + Rainbow(" Wrong!").red + Rainbow(" Expected: #{expected}").yellow
    end
  end
end

class Test
  def self.day(number)
    klass = Object.const_get("Day#{number.to_s}Test")
    unless klass
      Message.error "Day #{number} test not implemented"
      return
    end

    test = klass.new

    Test.output(1, test.part1, klass::ANSWER_PART1)
    Test.output(2, test.part2, klass::ANSWER_PART2)
  end

  def self.output(part, result, expected)
    if result == expected
      Message.test_success(part, result)
    else
      Message.test_fail(part, result, expected)
    end
  end
end

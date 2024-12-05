class Day2
  def parse_reports(input)
    input.split("\n").reduce([]) do |acc, line|
      acc << line.split(/\s+/).map(&:to_i)
    end
  end

  def check_report(report)
    type = report[0] < report[1] ? 'asc' : 'desc'

    report.each_with_index do |n, i|
      if i > 0
        if type == 'asc' && report[i] <= report[i - 1]
          return false
        elsif type == 'desc' && report[i] >= report[i - 1]
          return false
        else
          diff = (report[i] - report[i - 1]).abs
          return false if diff > 3
        end
      end
    end

    true
  end

  def part1(input)
    reports = parse_reports(input)

    reports.reduce(0) do |total, report|
      total += 1 if check_report(report)
      total
    end
  end

  def part2(input)
    reports = parse_reports(input)
    total = 0

    reports.each do |report|
      if check_report(report)
        total += 1
        next
      end

      report.each_with_index do |n, i|
        new_report = report.dup
        new_report.delete_at i

        if check_report(new_report)
          total += 1
          break
        end
      end
    end

    total
  end
end

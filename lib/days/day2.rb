class Day2
  def parse_reports(input)
    input.split("\n").reduce([]) do |acc, line|
      acc << line.split(/\s+/).map(&:to_i)
    end
  end

  def check_report(report)
    safe = true
    type = report[0] < report[1] ? 'asc' : 'desc'

    report.each_with_index do |n, i|
      if i > 0
        if type == 'asc' && report[i] <= report[i - 1]
          safe = false
          break
        elsif type == 'desc' && report[i] >= report[i - 1]
          safe = false
          break
        else
          diff = (report[i] - report[i - 1]).abs
          if diff < 1 || diff > 3
            safe = false
            break
          end
        end
      end
    end

    safe
  end

  def part1(input)
    reports = parse_reports(input)

    reports.reduce(0) do |total, report|
      total += 1 if check_report(report)
      total
    end
  end

  def part2(input)
    total = 0
    reports = parse_reports(input)

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

class Day13
  def parse_input(input)
    input.split("\n\n").map do |machine|
      a, b, p = machine.split("\n")
      {
        ax: a.match(/X\+(\d+),/)[1].to_i,
        ay: a.match(/Y\+(\d+)$/)[1].to_i,
        bx: b.match(/X\+(\d+),/)[1].to_i,
        by: b.match(/Y\+(\d+)$/)[1].to_i,
        px: p.match(/X=(\d+),/)[1].to_i,
        py: p.match(/Y=(\d+)$/)[1].to_i
      }
    end
  end

  def button_presses(machine)
    z3_solver = Z3::Solver.new
    machine => {ax:, ay:, bx:, by:, px:, py:}

    a = Z3.Int('a')
    b = Z3.Int('b')
    z3_solver.assert(ax * a + bx * b == px)
    z3_solver.assert(ay * a + by * b == py)

    return nil if z3_solver.unsatisfiable?

    {
      a: z3_solver.model[a].to_i,
      b: z3_solver.model[b].to_i
    }
  end

  def part1(input)
    machines = parse_input(input)

    machines.reduce(0) do |acc, machine|
      if (presses = button_presses(machine))
        acc += 3 * presses[:a] + presses[:b]
      end
      acc
    end
  end

  def part2(input)
    machines = parse_input(input)

    machines.reduce(0) do |acc, machine|
      machine[:px] += 10000000000000
      machine[:py] += 10000000000000

      if (presses = button_presses(machine))
        acc += 3 * presses[:a] + presses[:b]
      end
      acc
    end
  end
end

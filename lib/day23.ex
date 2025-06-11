defmodule AOC2015.Day23 do
  @moduledoc """
  ## Day 23 – Opening the Turing Lock

  little Jane Marie got her first computer for christmas, it comes with instructions and an example program, but the computer itself seems to be malfunctioning. help her

  The computer supports two registers (`a` and `b`) and six instructions:
  - `hlf r` – sets register `r` to half its current value
  - `tpl r` – sets register `r` to triple its current value
  - `inc r` – increments register `r` by 1
  - `jmp offset` – jumps to an instruction relative to the current position
  - `jie r, offset` – jumps if register `r` is even
  - `jio r, offset` – jumps if register `r` is exactly 1

  ### Part 1
  Simulate the program from the puzzle input with initial register values `a = 0`, `b = 0`,  
  and determine the final value in register `b`.

  ### Part 2
  Simulate the same program, but this time with `a = 1` and `b = 0` initially.  
  What is the final value in register `b`?
  """

  @doc """
  Read the puzzle input file
  """
  def input do
    File.read!("priv/inputs/day23.txt")
  end

  @doc """
  wrapper around part1, reads the puzzle input and return the answer for part 1
  """
  def part1(), do: part1(input())

  @doc """
  parses the input into instructions, simulates the program using `run/3` starting with `a = 0`, `b = 0`, and returns the final value in register `b`  
  """
  def part1(input) do
    _instructions =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn
        "jmp " <> offset ->
          {:jmp, String.to_integer(offset)}

        line ->
          [op, arg1 | rest] =
            line
            |> String.replace(",", "")
            |> String.split()

          case {op, rest} do
            {"hlf", []} -> {:hlf, arg1}
            {"tpl", []} -> {:tpl, arg1}
            {"inc", []} -> {:inc, arg1}
            {"jie", [offset]} -> {:jie, arg1, String.to_integer(offset)}
            {"jio", [offset]} -> {:jio, arg1, String.to_integer(offset)}
          end
      end)
      |> run(0, %{"a" => 0, "b" => 0})
      |> Map.get("b")
  end

  @doc """
  wrapper around part2, reads the puzzle input and return the answer for part 2
  """
  def part2(), do: part2(input())

  @doc """
  just like `part1/1`, but `a = 1`, returns `b` after run through all the instructions
  """
  def part2(input) do
    _instructions =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn
        "jmp " <> offset ->
          {:jmp, String.to_integer(offset)}

        line ->
          [op, arg1 | rest] =
            line
            |> String.replace(",", "")
            |> String.split()

          case {op, rest} do
            {"hlf", []} -> {:hlf, arg1}
            {"tpl", []} -> {:tpl, arg1}
            {"inc", []} -> {:inc, arg1}
            {"jie", [offset]} -> {:jie, arg1, String.to_integer(offset)}
            {"jio", [offset]} -> {:jio, arg1, String.to_integer(offset)}
          end
      end)
      |> run(0, %{"a" => 1, "b" => 0})
      |> Map.get("b")
  end

  defp run(instructions, ip, regs) when ip < 0 or ip >= length(instructions), do: regs

  defp run(instructions, ip, regs) do
    case Enum.at(instructions, ip) do
      {:hlf, r} ->
        run(instructions, ip + 1, Map.update!(regs, r, &div(&1, 2)))

      {:tpl, r} ->
        run(instructions, ip + 1, Map.update!(regs, r, &(&1 * 3)))

      {:inc, r} ->
        run(instructions, ip + 1, Map.update!(regs, r, &(&1 + 1)))

      {:jmp, offset} ->
        run(instructions, ip + offset, regs)

      {:jie, r, offset} ->
        if rem(regs[r], 2) == 0,
          do: run(instructions, ip + offset, regs),
          else: run(instructions, ip + 1, regs)

      {:jio, r, offset} ->
        if regs[r] == 1,
          do: run(instructions, ip + offset, regs),
          else: run(instructions, ip + 1, regs)
    end
  end
end

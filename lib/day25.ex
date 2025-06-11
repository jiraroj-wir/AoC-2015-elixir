defmodule AOC2015.Day25 do
  @moduledoc """
  ## Day 25 - Let It Snow

  santa’s weather machine uses a code printed on an infinite grid. you must find the code at a specific row and column using a custom diagonal traversal pattern and a specific formula to compute each code value.

  ### Part 1
  parse the target coordinate, calculate its position in the diagonal grid, then apply modular exponentiation to get the final code
  """

  @base 20_151_125
  @mult 252_533
  @mod 33_554_393

  @doc """
  read the puzzle input file
  """
  def input do
    File.read!("priv/inputs/day25.txt")
  end

  @doc """
  wrapper around part1, reads the puzzle input and return the answer for part 1
  """
  def part1(), do: part1(input())

  @doc """
  extracts the target `row` and `column` from the input, computes its order in the diagonal filling sequence and returns the code at that location using modular exponentiation
  """
  def part1(input) do
    {row, column} =
      input
      |> String.trim()
      |> String.split("\n", trim: true)
      |> Enum.reduce({"", ""}, fn line, _acc ->
        case String.split(line, " ", trim: true) do
          [
            "To",
            "continue,",
            "please",
            "consult",
            "the",
            "code",
            "grid",
            "in",
            "the",
            "manual.",
            "Enter",
            "the",
            "code",
            "at",
            "row",
            row,
            "column",
            column
          ] ->
            row = String.trim_trailing(row, ",")
            column = String.trim_trailing(column, ".")
            {String.to_integer(row), String.to_integer(column)}

          _ ->
            {"", ""}
        end
      end)

    index = order(row, column) - 1
    code = rem(@base * mod_pow(@mult, index, @mod), @mod)
    code
  end

  @doc """
  returns the index (1-based) of the cell at `{row, column}` in the diagonal filling pattern
  """
  def order(row, col) do
    diag = row + col - 1
    offset = row - 1
    div(diag * (diag + 1), 2) - offset
  end

  @doc false
  defp mod_pow(_base, 0, _mod), do: 1

  defp mod_pow(base, exp, mod) when rem(exp, 2) == 0 do
    half = mod_pow(base, div(exp, 2), mod)
    rem(half * half, mod)
  end

  defp mod_pow(base, exp, mod) do
    rem(base * mod_pow(base, exp - 1, mod), mod)
  end
end

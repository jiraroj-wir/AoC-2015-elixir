defmodule AOC2015.Day02 do
  @moduledoc """

  """

  @doc """
  read the puzzle input file
  """
  def input do
    File.read!("priv/inputs/day02.txt")
  end

  @doc """
  wrapper around part1, reads the puzzle input and return the answer for part 1
  """
  def part1(), do: part1(input())

  @doc """

  """
  def part1(input) do
    boxes =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [_a, _b, _c] =
          line
          |> String.split("x")
          |> Enum.map(&String.to_integer/1)
      end)

    total_area =
      boxes
      |> Enum.map(fn [x, y, z] ->
        [a, b, c] = Enum.sort([x, y, z])
        2 * a * b + 2 * a * c + 2 * b * c + a * b
      end)
      |> Enum.sum()

    total_area
  end
end

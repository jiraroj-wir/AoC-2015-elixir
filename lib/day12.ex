defmodule AOC2015.Day12 do
  @doc """
  read the puzzle input file
  """
  def input do
    File.read!("priv/inputs/day12.txt")
  end

  @doc """
  wrapper around part1, reads the puzzle input and return the answer for part 1
  """
  def part1(), do: part1(input())

  def part1(input) do
    Regex.scan(~r/-?\d+/, input)
    |> List.flatten()
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end
end

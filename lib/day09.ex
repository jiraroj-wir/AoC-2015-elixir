defmodule AOC2015.Day09 do
  @doc """
  read the puzzle input file
  """
  def input do
    File.read!("priv/inputs/day09.txt")
  end

  @doc """
  wrapper around part1, reads the puzzle input and return the answer for part 1
  """
  def part1(), do: part1(input())

  def part1(input) do
    adj_map =
      input
      |> String.split("\n", trim: true)
      |> Enum.reduce(%{}, fn line, map ->
        [city_1, "to", city_2, "=", dist] = String.split(line, " ", trim: true)
        dist = String.to_integer(dist)

        map
        |> Map.put({city_1, city_2}, dist)
        |> Map.put({city_2, city_1}, dist)
      end)

    IO.inspect(adj_map)
  end
end

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

  @doc """
  wrapper around part2, reads the puzzle input and return the answer for part 2
  """
  def part2(), do: part2(input())

  def part2(input) do
    input
    |> Jason.decode!()
    |> sum_without_red()
  end

  defp sum_without_red(%{} = map) do
    case "red" in Map.values(map) do
      true ->
        0

      false ->
        map
        |> Map.values()
        |> Enum.map(&sum_without_red/1)
        |> Enum.sum()
    end
  end

  defp sum_without_red(map) when is_map(map) do
    map
    |> Map.values()
    |> Enum.map(&sum_without_red/1)
    |> Enum.sum()
  end

  defp sum_without_red([head | tail]), do: sum_without_red(head) + sum_without_red(tail)
  defp sum_without_red([]), do: 0
  defp sum_without_red(n) when is_number(n), do: n
  defp sum_without_red(_), do: 0
end

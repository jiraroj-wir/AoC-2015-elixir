defmodule AOC2015.Day24 do
  @moduledoc """
  ## Day 24 - It Hangs in the Balance

  given a list of package weights, help santa packs them into his sleigh

  ### Part 1
  divide them into three groups, the ones in santa's passenger compartment needs to have the smallest members, and the smallest quantum entanglement if member size are equal

  ### Part 2
  just like part 1, but divide presents into 4 gropus instead
  """

  @doc """
  Read the puzzle input file from `priv/inputs/day24.txt` and return as raw string.
  """
  def input, do: File.read!("priv/inputs/day24.txt")

  @doc """
  Wrapper for `part1/1`, reads input and returns the solution for Part 1 (3 groups).
  """
  def part1(), do: part1(input())

  @group_count_1 3

  @doc """
  after parsing input into list integers, sort them descendingly, dividing packages into 3 equal-weightfindings and finding the minimal quantum entanglement for the smallest valid group using `find_best_group/2`
  """
  def part1(input) do
    packages =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.sort()
      |> Enum.reverse()

    target = div(Enum.sum(packages), @group_count_1)
    find_best_group(packages, target)
  end

  @doc """
  Wrapper for `part2/1`, reads input and returns the solution for Part 2 (4 groups).
  """
  def part2(), do: part2(input())

  @group_count_2 4

  @doc """
  just like `part1/1`, but with 4 groups
  """
  def part2(input) do
    packages =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.sort()
      |> Enum.reverse()

    target = div(Enum.sum(packages), @group_count_2)
    find_best_group(packages, target)
  end

  @doc """
  finds the best (smallest size + lowest quantum entanglement value) group of packages that sum to `target`, stops early once a valid group size is found.
  """
  def find_best_group(packages, target) do
    1..length(packages)
    |> Enum.reduce_while(nil, fn size, _acc ->
      valid =
        packages
        |> combinations(size)
        |> Enum.filter(&(Enum.sum(&1) == target))

      case valid do
        [] ->
          {:cont, nil}

        groups ->
          qe =
            groups
            |> Enum.map(&quantum_entanglement/1)
            |> Enum.min()

          {:halt, qe}
      end
    end)
  end

  defp combinations(_, 0), do: [[]]

  defp combinations([], _), do: []

  defp combinations([h | t], k) do
    for(rest <- combinations(t, k - 1), do: [h | rest]) ++ combinations(t, k)
  end

  defp quantum_entanglement(list), do: Enum.reduce(list, 1, &*/2)
end

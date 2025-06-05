defmodule AOC2015.Day17 do
  @moduledoc """
  ## Day 17 - No Such Thing as Too Much

  you're trying to fill containers to exactly fit 150 liters of eggnog. you have a list of container sizes. determine in how many different ways you can choose containers that exactly sum to the target volume.

  ### Part 1
  count all combinations of containers that sum up to exactly 150 liters.

  ### Part 2
  from those valid combinations, count only those that use the minimal number of containers.
  """

  @target 150

  @doc """
  read the puzzle input file
  """
  def input do
    File.read!("priv/inputs/day17.txt")
  end

  @doc """
  wrapper around part1, reads the puzzle input and return the answer for part 1
  """
  def part1(), do: part1(input(), @target)

  @doc """
  Count all valid combinations of container sizes that sum exactly to the target volume
  """
  def part1(input, target) do
    containers =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer(String.trim(&1)))

    dp(containers, 0, target, 0, %{}) |> elem(0) |> length()
  end

  @doc """
  wrapper around part1, reads the puzzle input and return the answer for part 1
  """
  def part2(), do: part2(input(), @target)

  @doc """
  From the valid combinations found in `part1/2`, return the count of combinations that use the smallest number of containers
  """
  def part2(input, target) do
    containers =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.to_integer(String.trim(&1)))

    used_counts = dp(containers, 0, target, 0, %{}) |> elem(0)
    min_used = Enum.min(used_counts)
    Enum.count(used_counts, &(&1 == min_used))
  end

  defp dp(_containers, _idx, 0, used_count, memo), do: {[used_count], memo}

  defp dp(containers, idx, remaining_cap, _used_count, memo)
       when remaining_cap < 0 or idx == length(containers),
       do: {[], memo}

  defp dp(containers, idx, remaining_cap, used_count, memo) do
    key = {idx, remaining_cap, used_count}

    case Map.get(memo, key) do
      nil ->
        {skip, memo1} = dp(containers, idx + 1, remaining_cap, used_count, memo)

        {use, memo2} =
          dp(containers, idx + 1, remaining_cap - Enum.at(containers, idx), used_count + 1, memo1)

        result = skip ++ use
        {result, Map.put(memo2, key, result)}

      cached ->
        {cached, memo}
    end
  end
end

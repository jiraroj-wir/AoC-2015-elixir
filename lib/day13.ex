defmodule AOC2015.Day13 do
  @moduledoc """
  ## Day 13 - Knights of the Dinner Table

  to avoid tension on the dinner table, you need to arrange seatings that got the highest total change in happiness

  ### Part 1
  find the highest total change of happiness 

  ### Part 2
  now, you have to join in, but you are super neutral, so your happiness units to anyone is 0, vice versa. 
  """
  @doc """
  read the puzzle input file
  """
  def input do
    File.read!("priv/inputs/day13.txt")
  end

  @doc """
  wrapper around part1, reads the puzzle input and return the answer for part 1
  """
  def part1(), do: part1(input())

  @doc """
  after preprocessed the input, put them into the map and set with the help of elixir powerful pattern matching, then just generate all the permutation with `permute/1` and checks all of them with `seat_happiness/2` and return the max value
  """
  def part1(input) do
    {adj_map, people} =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.trim_trailing(&1, "."))
      |> Enum.reduce({%{}, MapSet.new()}, fn line, {map, set} ->
        [
          name_1,
          "would",
          state,
          unit,
          "happiness",
          "units",
          "by",
          "sitting",
          "next",
          "to",
          name_2
        ] =
          String.split(line, " ", trim: true)

        multiplier = %{"gain" => 1, "lose" => -1}
        unit = String.to_integer(unit) * multiplier[state]

        {
          map
          |> Map.put({name_1, name_2}, unit),
          set
          |> MapSet.put(name_1)
          |> MapSet.put(name_2)
        }
      end)

    people
    |> MapSet.to_list()
    |> permute()
    |> Enum.map(fn seat -> {seat, seat_happiness(seat, adj_map)} end)
    |> Enum.max_by(fn {_, happiness} -> happiness end)
    |> then(fn {_, happiness} -> happiness end)
  end

  @doc """
  wrapper around part2, reads the puzzle input and return the answer for part 2
  """
  def part2(), do: part2(input())

  @doc """
  just like `part1/1`, but this time add yourself in both map and set.
  """
  def part2(input) do
    {adj_map, people} =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.trim_trailing(&1, "."))
      |> Enum.reduce({%{}, MapSet.new()}, fn line, {map, set} ->
        [
          name_1,
          "would",
          state,
          unit,
          "happiness",
          "units",
          "by",
          "sitting",
          "next",
          "to",
          name_2
        ] =
          String.split(line, " ", trim: true)

        multiplier = %{"gain" => 1, "lose" => -1}
        unit = String.to_integer(unit) * multiplier[state]

        {
          map
          |> Map.put({name_1, name_2}, unit),
          set
          |> MapSet.put(name_1)
          |> MapSet.put(name_2)
        }
      end)

    Enum.reduce(MapSet.to_list(people), adj_map, fn person, map ->
      map
      |> Map.put({"me", person}, 0)
      |> Map.put({person, "me"}, 0)
    end)

    people =
      people
      |> MapSet.put("me")

    people
    |> MapSet.to_list()
    |> permute()
    |> Enum.map(fn seat -> {seat, seat_happiness(seat, adj_map)} end)
    |> Enum.max_by(fn {_, happiness} -> happiness end)
    |> then(fn {_, happiness} -> happiness end)
  end

  defp permute([]), do: [[]]

  defp permute(list) do
    for elem <- list, rest <- permute(List.delete(list, elem)) do
      [elem | rest]
    end
  end

  defp seat_happiness(seat, adj_map) do
    seat
    |> Enum.concat([hd(seat)])
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.reduce(0, fn [p1, p2], acc ->
      acc + Map.get(adj_map, {p1, p2}, 0) + Map.get(adj_map, {p2, p1}, 0)
    end)
  end
end

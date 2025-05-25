defmodule AOC2015.Day09 do
  @moduledoc """
  ## Day 09 - All in a Single Night

  help santa find the route through every cities given the distance between them (complete graph)

  ### Part 1
  find the shortest route

  ### Part 2
  find the longest route
  """

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

  @doc """
  preprocessed the input into `adj_map` of two cities and its distance, then make all the route permutation of every city and find the `route_distance` - get the shortest one
  """
  def part1(input) do
    {adj_map, cities} =
      input
      |> String.split("\n", trim: true)
      |> Enum.reduce({%{}, MapSet.new()}, fn line, {map, set} ->
        [city_1, "to", city_2, "=", dist] = String.split(line, " ", trim: true)
        dist = String.to_integer(dist)

        {
          map
          |> Map.put({city_1, city_2}, dist)
          |> Map.put({city_2, city_1}, dist),
          set
          |> MapSet.put(city_1)
          |> MapSet.put(city_2)
        }
      end)

    cities
    |> MapSet.to_list()
    |> permute()
    |> Enum.map(fn route -> {route, route_distance(route, adj_map)} end)
    |> Enum.min_by(fn {_, dist} -> dist end)
    |> then(fn {_, dist} -> dist end)
  end

  @doc """
  wrapper around part2, reads the puzzle input and return the answer for part 2
  """
  def part2(), do: part2(input())

  @doc """
  just like `part1/1`, but this time, find the longest route. Just change the `min_by` enum into `max_by`
  """
  def part2(input) do
    {adj_map, cities} =
      input
      |> String.split("\n", trim: true)
      |> Enum.reduce({%{}, MapSet.new()}, fn line, {map, set} ->
        [city_1, "to", city_2, "=", dist] = String.split(line, " ", trim: true)
        dist = String.to_integer(dist)

        {
          map
          |> Map.put({city_1, city_2}, dist)
          |> Map.put({city_2, city_1}, dist),
          set
          |> MapSet.put(city_1)
          |> MapSet.put(city_2)
        }
      end)

    cities
    |> MapSet.to_list()
    |> permute()
    |> Enum.map(fn route -> {route, route_distance(route, adj_map)} end)
    |> Enum.max_by(fn {_, dist} -> dist end)
    |> then(fn {_, dist} -> dist end)
  end

  defp route_distance([_], _map), do: 0

  defp route_distance([a, b | rest], map) do
    Map.get(map, {a, b}) + route_distance([b | rest], map)
  end

  defp permute([]), do: [[]]

  defp permute(list) do
    for elem <- list, rest <- permute(List.delete(list, elem)) do
      [elem | rest]
    end
  end
end

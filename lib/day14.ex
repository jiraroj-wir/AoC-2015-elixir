defmodule AOC2015.Day14 do
  @moduledoc """
  ## Day 14 - Reindeer Olympics

  help santa finds the winner of a raindeer flying competition

  ### Part 1
  find the distance that the winning deer traveled in a given time

  ### Part 2
  rule changed, each second, a leading deer get a point, finds the maximum point 
  """

  @total_time 2503
  @doc """
  read the puzzle input file
  """
  def input do
    File.read!("priv/inputs/day14.txt")
  end

  @doc """
  wrapper around part1, reads the puzzle input and return the answer for part 1
  """
  def part1(), do: part1(input(), @total_time)

  @doc """
    after preprocessing the input values, map them into `raindeers`and spawns a task for each one, computes its final distance using `total_distance/3`; when all tasks are done, returns the max distance of any raindeer
  """
  def part1(input, total_time) do
    raindeers =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.trim_trailing(&1, "."))
      |> Enum.reduce(%{}, fn line, map ->
        [
          name,
          "can",
          "fly",
          speed,
          "km/s",
          "for",
          fly_time,
          "seconds,",
          "but",
          "then",
          "must",
          "rest",
          "for",
          rest_time,
          "seconds"
        ] = String.split(line, " ", trim: true)

        map
        |> Map.put(
          name,
          {String.to_integer(speed), String.to_integer(fly_time), String.to_integer(rest_time)}
        )
      end)

    raindeers
    |> Enum.map(fn {name, stats} ->
      Task.async(fn -> total_distance(name, stats, total_time) end)
    end)
    |> Enum.map(&Task.await/1)
    |> Enum.map(fn {_name, dist} -> dist end)
    |> Enum.max()
  end

  @doc """
  wrapper around part2, reads the puzzle input and return the answer for part 2
  """
  def part2(), do: part2(input(), @total_time)

  @doc """
  simulates second-by-second judgement of the race, iterate through every seconds of the race and awards 1 point to the winning raindeer(s), returns the highest scores
  """
  def part2(input, total_time) do
    raindeers =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&String.trim_trailing(&1, "."))
      |> Enum.reduce(%{}, fn line, map ->
        [
          name,
          "can",
          "fly",
          speed,
          "km/s",
          "for",
          fly_time,
          "seconds,",
          "but",
          "then",
          "must",
          "rest",
          "for",
          rest_time,
          "seconds"
        ] = String.split(line, " ", trim: true)

        map
        |> Map.put(
          name,
          {String.to_integer(speed), String.to_integer(fly_time), String.to_integer(rest_time)}
        )
      end)

    points =
      raindeers
      |> Enum.map(fn {name, _} -> {name, 0} end)
      |> Map.new()

    1..total_time
    |> Enum.reduce(points, fn t, acc ->
      results =
        raindeers
        |> Enum.map(fn {name, stats} ->
          Task.async(fn -> total_distance(name, stats, t) end)
        end)
        |> Enum.map(&Task.await/1)

      max_dist =
        results
        |> Enum.map(fn {_name, d} -> d end)
        |> Enum.max()

      leaders =
        results
        |> Enum.filter(fn {_name, d} -> d == max_dist end)

      Enum.reduce(leaders, acc, fn {name, _}, acc2 ->
        Map.update!(acc2, name, &(&1 + 1))
      end)
    end)
    |> Map.values()
    |> Enum.max()
  end

  defp total_distance(name, {speed, fly_time, rest_time}, total_time) do
    cycle_time = fly_time + rest_time
    full_cycles = div(total_time, cycle_time)
    remaining_time = rem(total_time, cycle_time)
    actual_fly_time = full_cycles * fly_time + min(fly_time, remaining_time)
    {name, actual_fly_time * speed}
  end
end

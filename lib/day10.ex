defmodule AOC2015.Day10 do
  @moduledoc """
  ## Day 10 - Elves Look, Elves Say

  it just a look and say recursion

  ### Part 1
  length of the result of look and say 40 times

  ### Part 2
  length of the result of look and say 50 times
  """
  @doc """
  read the puzzle input file
  """
  def input do
    File.read!("priv/inputs/day10.txt")
  end

  @doc """
  wrapper around part1, reads the puzzle input and return the answer for part 1
  """
  def part1(), do: part1(input(), 40)

  @doc """
  just trim the string, call `look_and_say/2` and wait to return the its length
  """
  def part1(input, times) do
    input
    |> String.trim()
    |> look_and_say(times)
    |> String.length()
  end

  @doc """
  wrapper around part2, reads the puzzle input and return the answer for part 2
  """
  def part2(), do: part1(input(), 50)

  def look_and_say(input, 0), do: input

  @doc """
  Performs the look-and-say transformation recursively.

  - Base case: returns the input unchanged when `n` reaches 0.
  - Recursive case:
    - `Enum.chunk_by(& &1)`: groups adjacent identical digits.
      Example:

          ["1", "1", "2", "3", "3", "3"] 
          => [["1", "1"], ["2"], ["3", "3", "3"]]

    - `Enum.map_join(fn group -> count <> digit end)`: 
      Converts each group into a string of count followed by the digit.
      - `count = length(group)`
      - `digit = hd(group)`

  This process repeats `n` times.
  """
  def look_and_say(input, n) do
    input
    |> String.graphemes()
    |> Enum.chunk_by(& &1)
    |> Enum.map_join(fn group -> "#{length(group)}#{hd(group)}" end)
    |> look_and_say(n - 1)
  end
end

defmodule AOC2015.Day08 do
  @moduledoc """
  ## Day 08 - Matchsticks

  Most programming languages provide an escape character `\\` for some characters in a string:
  - `\\\\` for a single `\\` character
  - `\\\"` for a single `"` character
  - `\\xAB` for ASCII hexadecimal `AB`

  ### Part 1
  Find the sum of the difference between the number of characters of code for string literals and the number of characters in memory for the values of the string.

  ### Part 2
  Find the sum of the difference between the number of encoded representations and the original code representation.
  """

  @doc """
  read the puzzle input file
  """
  def input do
    File.read!("priv/inputs/day08.txt")
  end

  @doc """
  wrapper around part1, reads the puzzle input and return the answer for part 1
  """
  def part1(), do: part1(input())

  @doc """
  count the difference of string length and its value  
  """
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn line, diff ->
      string_code =
        line
        |> String.to_charlist()
        |> Enum.reduce(0, fn _ch, acc -> acc + 1 end)

      string_values =
        line
        |> String.to_charlist()
        |> count_char(0)

      diff + (string_code - string_values)
    end)
  end

  @doc """
  wrapper around part2, reads the puzzle input and return the answer for part 2
  """
  def part2(), do: part2(input())

  @doc """
  count just the frequencies of `\` and `"", plus 2 for each lines
  """
  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn line, diff ->
      representation =
        line
        |> String.to_charlist()
        |> Enum.filter(&(&1 in [?\\, ?\"]))
        |> Enum.frequencies()
        |> then(fn freq -> 2 + Map.get(freq, ?\", 0) + Map.get(freq, ?\\, 0) end)

      diff + representation
    end)
  end

  defp count_char([], acc), do: acc

  defp count_char([?\\, ?x, _a, _b | rest], acc),
    do: count_char(rest, acc + 1)

  defp count_char([?\\, _ | rest], acc),
    do: count_char(rest, acc + 1)

  defp count_char([?" | rest], acc),
    do: count_char(rest, acc)

  defp count_char([_ | rest], acc),
    do: count_char(rest, acc + 1)
end

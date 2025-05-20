defmodule AOC2015.Day05 do
  @moduledoc """
  ## Day 05 - Doesn't He Have Intern-Elves For This?

  santa needs help figuring out which strings in his text file are naughty or nice.

  ### Part 1
  - it contains at least three vowels (a, e, i, o, u).
  - it contains at least one letter that appears twice in a row.
  - it does not contain the substrings "ab", "cd", "pq", or "xy".

  ### Part 2
  - it contains a pair of any two letters that appears at least twice in the string without overlapping.
  - it contains at least one letter which repeats with exactly one letter between them.
  """

  @doc """
  read the puzzle input file
  """
  def input do
    File.read!("priv/inputs/day05.txt")
  end

  @doc """
  wrapper around part1, reads the puzzle input and return the answer for part 1
  """
  def part1(), do: part1(input())

  @doc """
  count amount of nice string by criteria 1
  """
  @forbidden_substrings ["ab", "cd", "pq", "xy"]
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn line, acc ->
      no_forbidden_substring? =
        Enum.all?(@forbidden_substrings, fn sub ->
          not String.contains?(line, sub)
        end)

      contains_at_least_three_vowels? =
        Regex.scan(~r/[aeiou]/, line) |> length() >= 3

      contains_repeated_char? =
        Regex.match?(~r/(.)\1/, line)

      if no_forbidden_substring? and contains_at_least_three_vowels? and contains_repeated_char? do
        acc + 1
      else
        acc
      end
    end)
  end

  @doc """
  wrapper around part2, reads the puzzle input and return the answer for part 2
  """
  def part2(), do: part2(input())

  @doc """
  count amount of nice string by criteria 2
  """
  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn line, acc ->
      pair_of_two_letters? = Regex.match?(~r/(..).*\1/, line)
      repeats_char_with_single_space? = Regex.match?(~r/(.).\1/, line)

      if pair_of_two_letters? and repeats_char_with_single_space? do
        acc + 1
      else
        acc
      end
    end)
  end
end

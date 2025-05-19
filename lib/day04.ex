defmodule AOC2015.Day04 do
  @moduledoc """
  ## Day 04 - The Ideal Stocking Stuffer

  help santa mines AdventCoins, by using MD5 hash funciton on a concatenated string of special key <> some numbers

  ### Part 1
  the first five character of the hash must be '0', find the lowest numbers that do so

  ### Part 2
  the first six character of the hash must be '0', find the lowest numbers that do so
  """

  @doc """
  read the puzzle input file
  """
  def input do
    File.read!("priv/inputs/day04.txt")
  end

  @doc """
  wrapper around part1, reads the puzzle input and return the answer for part 1
  """
  def part1(), do: part1(input())

  @doc """
  returns the first numbers that when concatenated with secret key, gives a hash that the first 5 characters are '0'
  """
  def part1(input) do
    input = String.trim(input)
    md5 = fn str -> :crypto.hash(:md5, str) end

    Stream.iterate(0, &(&1 + 1))
    |> Enum.find(fn num ->
      (input <> Integer.to_string(num))
      |> md5.()
      |> Base.encode16(case: :lower)
      |> String.starts_with?("00000")
    end)
  end

  @doc """
  wrapper around part2, reads the puzzle input and return the answer for part 2
  """
  def part2(), do: part2(input())

  @doc """
  returns the first numbers that when concatenated with secret key, gives a hash that the first 6 characters are '0'
  """
  def part2(input) do
    input = String.trim(input)
    md5 = fn str -> :crypto.hash(:md5, str) end

    Stream.iterate(0, &(&1 + 1))
    |> Enum.find(fn num ->
      (input <> Integer.to_string(num))
      |> md5.()
      |> Base.encode16(case: :lower)
      |> String.starts_with?("000000")
    end)
  end
end

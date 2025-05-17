defmodule AOC2015.Day02 do
  @moduledoc """
  ## Day 02 - I Was Told There Would Be No Math

  elves are running low on paper and ribbon, thus needing to order more, precisely. 
  - given length x width x height

  ### Part 1
  find the total area of wrapping paper needed to wrap all boxes.

  ### Part 2
  find the total length of ribbon needed to wrap all boxes.
  """

  @doc """
  read the puzzle input file
  """
  def input do
    File.read!("priv/inputs/day02.txt")
  end

  @doc """
  wrapper around part1, reads the puzzle input and return the answer for part 1
  """
  def part1(), do: part1(input())

  @doc """
  takes lines of dimentions, parse and sort them, then return the total area 
  """
  def part1(input) do
    boxes =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [_a, _b, _c] =
          line
          |> String.split("x")
          |> Enum.map(&String.to_integer/1)
      end)

    total_area =
      boxes
      |> Enum.map(fn [x, y, z] ->
        [a, b, c] = Enum.sort([x, y, z])
        2 * a * b + 2 * a * c + 2 * b * c + a * b
      end)
      |> Enum.sum()

    total_area
  end

  @doc """
  wrapper around part2, reads the puzzle input and return the answer for part 1
  """
  def part2(), do: part2(input())

  @doc """
  takes lines of dimentions, parse and sort them, then return the total length
  """
  def part2(input) do
    boxes =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [_a, _b, _c] =
          line
          |> String.split("x")
          |> Enum.map(&String.to_integer/1)
      end)

    total_length =
      boxes
      |> Enum.map(fn [x, y, z] ->
        [a, b, c] = Enum.sort([x, y, z])
        2 * a + 2 * b + a * b * c
      end)
      |> Enum.sum()

    total_length
  end
end

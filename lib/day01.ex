defmodule AOC2015.Day01 do
  @moduledoc """
  ## Day 01 – Not Quite Lisp 

  santa is trying to navigate a building using a series of parentheses.
  - `(` means go up a floor
  - `)` means go down a floor

  ### Part 1
  figure out what floor Santa ends up on after all instructions.

  ### Part 2
  find the position of the first character that causes santa to enter the basement (floor == -1).
  """

  @doc """
  read the puzzle input file
  """
  def input do
    File.read!("priv/inputs/day1.txt")
  end

  @doc """
  wrapper around part1, reads the puzzle input and return the answer for part 1
  """
  def part1(), do: part1(input())

  @doc """
  takes a string of parentheses, and return the final floor
  """
  def part1(input) do
    chars = String.graphemes(input)

    Enum.reduce(chars, 0, fn char, acc ->
      case char do
        "(" -> acc + 1
        ")" -> acc - 1
        _ -> acc
      end
    end)
  end

  @doc """
  wrapper around part2, reads the puzzle input and return the answer for part 2
  """
  def part2(), do: part2(input())

  @doc """
  takes a string of parentheses, iterate through them, :halt when floor == -1 and return the index
  """
  def part2(input) do
    chars = String.graphemes(input)

    Enum.reduce_while(chars, {0, 0}, fn char, {floor, idx} ->
      new_floor =
        case char do
          "(" -> floor + 1
          ")" -> floor - 1
          _ -> floor
        end

      new_idx = idx + 1

      if new_floor == -1 do
        {:halt, new_idx}
      else
        {:cont, {new_floor, new_idx}}
      end
    end)
  end
end

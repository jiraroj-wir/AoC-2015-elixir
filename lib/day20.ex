defmodule AOC2015.Day20 do
  @moduledoc """
  ## Day 20 - Infinite Elves and Infinite Houses

  infinite number of elves delivers presents equivalent to 10 times of their number to infinite number of houses

  ### Part 1
  find the first houses that exceed the target presents

  ### Part 2
  each elves will only delivers to 50 houses, 11 times their numbers each
  """

  @limit 1_000_000

  @doc """
  Read the puzzle input file.
  """
  def input do
    File.read!("priv/inputs/day20.txt")
  end

  @doc """
  Wrapper around part1, reads the puzzle input and returns the answer for part 1.
  """
  def part1(), do: part1(input())

  @doc """
  do a sieve accumulator of every number, from 1 to `@limit` - a few should reach our `target`, so we just add up `10 * elf_number` to every multiple of `elf_number`, checks for the first `house` that exceed the `target`
  """
  def part1(input) do
    input
    |> String.trim()
    |> String.to_integer()
    |> then(fn target ->
      1..@limit
      |> Enum.reduce(:array.new(@limit + 1, default: 0), fn elf, acc ->
        Enum.reduce(elf..@limit//elf, acc, fn house, acc2 ->
          :array.set(house, :array.get(house, acc2) + elf * 10, acc2)
        end)
      end)
      |> then(fn presents ->
        1..@limit
        |> Enum.find(fn house ->
          :array.get(house, presents) >= target
        end)
      end)
    end)
  end

  @doc """
  Wrapper around part2, reads the puzzle input and returns the answer for part 2.
  """
  def part2(), do: part2(input())

  @doc """
  just like `part1/1`, but we changed the rules: each elf delivers to only 50 houses and each house got `11 * elf_number` presents, find the first `house` that exceed `target`
  """
  def part2(input) do
    input
    |> String.trim()
    |> String.to_integer()
    |> then(fn target ->
      1..@limit
      |> Enum.reduce(:array.new(@limit + 1, default: 0), fn elf, acc ->
        Enum.reduce(1..50, acc, fn i, acc2 ->
          house = elf * i

          if house > @limit do
            acc2
          else
            :array.set(house, :array.get(house, acc2) + elf * 11, acc2)
          end
        end)
      end)
      |> then(fn presents ->
        1..@limit
        |> Enum.find(fn house ->
          :array.get(house, presents) >= target
        end)
      end)
    end)
  end
end

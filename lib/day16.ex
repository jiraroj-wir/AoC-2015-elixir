defmodule AOC2015.Day16 do
  @moduledoc """
  ## Day 16 - Aunt Sue

  one of your 500 aunt `"Sue"` sent you a gift, with the help of the **MFCSAM** machine, find which one is it. each aunt `"Sue"` got her own properties (3 of these): `"children", "cats", "samoyedds", "pomeranians", "akitas", "vizslas", "goldfish", "trees", "cars", "perfumens"`

  ### Part 1
  all the properties of that aunt `"sue"` must match the ones from the **MFCSAM** machine, return her number

  ### Part 2
  `"cats", "trees"` value must be greater than the ones from **MFCSAM**, and `"pomeranians", "goldfish"` values must be less than the ones from **MFCSAM**, the rest remain the same - equal
  """
  @mfcsam %{
    "children" => 3,
    "cats" => 7,
    "samoyeds" => 2,
    "pomeranians" => 3,
    "akitas" => 0,
    "vizslas" => 0,
    "goldfish" => 5,
    "trees" => 3,
    "cars" => 2,
    "perfumes" => 1
  }

  @doc """
  Read the puzzle input file
  """
  def input do
    File.read!("priv/inputs/day16.txt")
  end

  @doc """
  wrapper around part1, reads the puzzle input and return the answer for part 1
  """
  def part1(), do: part1(input())

  @doc """
  after preprocessed the input, just check for the ones that all properties match **MFCSAM**, return number 
  """
  def part1(input) do
    sue_map =
      input
      |> String.split("\n", trim: true)
      |> Enum.reduce(%{}, fn line, map ->
        [
          "Sue",
          number,
          key_1,
          val_1,
          key_2,
          val_2,
          key_3,
          val_3
        ] = String.split(line, " ", trim: true)

        sue_number = String.trim_trailing(number, ":") |> String.to_integer()

        keys = [key_1, key_2, key_3] |> Enum.map(&String.trim_trailing(&1, ":"))

        vals =
          [val_1, val_2, val_3]
          |> Enum.map(&String.trim_trailing(&1, ","))
          |> Enum.map(&String.to_integer/1)

        props = Enum.zip(keys, vals) |> Enum.into(%{})

        Map.put(map, sue_number, props)
      end)

    Enum.find(sue_map, fn {_num, props} ->
      Enum.all?(props, fn {k, v} ->
        Map.get(@mfcsam, k) == v
      end)
    end)
    |> then(fn {num, _} -> num end)
  end

  @doc """
  wrapper around part2, reads the puzzle input and return the answer for part 2
  """
  def part2(), do: part2(input())

  @doc """
  just like `part1/1`, the only change is in the checking condition, allows `["cats", "trees"]` values to be greater than the ones from **MFCSAM** and `["pomeranians", "goldfish"]` values to be less than **MFCSAM**, else needs to be equal, return number
  """
  def part2(input) do
    sue_map =
      input
      |> String.split("\n", trim: true)
      |> Enum.reduce(%{}, fn line, map ->
        [
          "Sue",
          number,
          key_1,
          val_1,
          key_2,
          val_2,
          key_3,
          val_3
        ] = String.split(line, " ", trim: true)

        sue_number = String.trim_trailing(number, ":") |> String.to_integer()

        keys = [key_1, key_2, key_3] |> Enum.map(&String.trim_trailing(&1, ":"))

        vals =
          [val_1, val_2, val_3]
          |> Enum.map(&String.trim_trailing(&1, ","))
          |> Enum.map(&String.to_integer/1)

        props = Enum.zip(keys, vals) |> Enum.into(%{})

        Map.put(map, sue_number, props)
      end)

    Enum.find(sue_map, fn {_num, props} ->
      Enum.all?(props, fn {k, v} ->
        cond do
          k in ["cats", "trees"] -> v > @mfcsam[k]
          k in ["pomeranians", "goldfish"] -> v < @mfcsam[k]
          true -> v == @mfcsam[k]
        end
      end)
    end)
    |> then(fn {num, _} -> num end)
  end
end

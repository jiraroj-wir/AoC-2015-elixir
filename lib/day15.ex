defmodule AOC2015.Day15 do
  @moduledoc """
  ## Day 15 - Science for Hungry People

  find the right proportion for each ingredients - the ones that gives the most score in combined

  ### Part 1
  find the right proportion for each ingredients, with 100 full teaspoon

  ### Part 2
  find the right proportion for each ingredients that got exactly 500 calories
  """

  @doc """
  read the puzzle input file
  """
  def input do
    File.read!("priv/inputs/day15.txt")
  end

  @doc """
  wrapper around part1, reads the puzzle input and return the answer for part 1
  """
  def part1(), do: part1(input())

  @doc """
  map and clean each ingredient and its values with the help of template matching, then generate all permutation possible, pass it into `find_score/1`, get the max values and return just the scores
  """
  def part1(input) do
    ingredients =
      input
      |> String.split("\n", trim: true)
      |> Enum.reduce(%{}, fn line, acc ->
        [
          ingredient,
          "capacity",
          cap_val,
          "durability",
          dur_val,
          "flavor",
          fla_val,
          "texture",
          tex_val,
          "calories",
          cal_val
        ] = String.split(line, " ", trim: true)

        name = String.trim_trailing(ingredient, ":")

        values =
          [
            cap_val,
            dur_val,
            fla_val,
            tex_val,
            cal_val
          ]
          |> Enum.map(&String.trim_trailing(&1, ","))
          |> Enum.map(&String.to_integer/1)
          |> List.to_tuple()

        Map.put(acc, name, values)
      end)

    0..100
    |> Enum.flat_map(fn a ->
      0..(100 - a)
      |> Enum.flat_map(fn b ->
        0..(100 - a - b)
        |> Enum.map(fn c ->
          d = 100 - a - b - c
          [a, b, c, d]
        end)
      end)
    end)
    |> find_score(ingredients)
    |> Enum.max_by(fn {_, score, _} -> score end)
    |> then(fn {_, score, _} -> score end)
  end

  @doc """
  wrapper around part2, reads the puzzle input and return the answer for part 2
  """
  def part2(), do: part2(input())

  @doc """
  just like `part1/1`, but this time check `calories` arguemnt from `find_score/1` - it should be 500, returns the max values that also satisfy the calorie requirement
  """
  def part2(input) do
    ingredients =
      input
      |> String.split("\n", trim: true)
      |> Enum.reduce(%{}, fn line, acc ->
        [
          ingredient,
          "capacity",
          cap_val,
          "durability",
          dur_val,
          "flavor",
          fla_val,
          "texture",
          tex_val,
          "calories",
          cal_val
        ] = String.split(line, " ", trim: true)

        name = String.trim_trailing(ingredient, ":")

        values =
          [
            cap_val,
            dur_val,
            fla_val,
            tex_val,
            cal_val
          ]
          |> Enum.map(&String.trim_trailing(&1, ","))
          |> Enum.map(&String.to_integer/1)
          |> List.to_tuple()

        Map.put(acc, name, values)
      end)

    0..100
    |> Enum.flat_map(fn a ->
      0..(100 - a)
      |> Enum.flat_map(fn b ->
        0..(100 - a - b)
        |> Enum.map(fn c ->
          d = 100 - a - b - c
          [a, b, c, d]
        end)
      end)
    end)
    |> find_score(ingredients)
    |> Enum.filter(fn {_, _, cal} -> cal == 500 end)
    |> Enum.max_by(fn {_, score, _} -> score end)
    |> then(fn {_, score, _} -> score end)
  end

  @doc """
  mostly just normal arithmatic calculations, returns a tuple of `{permutation, Enum.product(totals), calories}}`
  """
  def find_score(permutation, ingredients) do
    ingredient_values = Map.values(ingredients)

    Enum.map(permutation, fn perm ->
      {totals, calories} =
        Enum.zip(perm, ingredient_values)
        |> Enum.reduce({[0, 0, 0, 0], 0}, fn {amount, {cap, dur, fla, tex, cal}},
                                             {[t1, t2, t3, t4], cal_acc} ->
          {
            [
              t1 + amount * cap,
              t2 + amount * dur,
              t3 + amount * fla,
              t4 + amount * tex
            ],
            cal_acc + amount * cal
          }
        end)

      totals = Enum.map(totals, &max(&1, 0))

      {permutation, Enum.product(totals), calories}
    end)
  end
end

defmodule AOC2015.Day18 do
  @moduledoc """
  ## Day 18 - Like a GIF For Your Yard

  due to fire code restriction, you are allowed to light up only 10000 (100*100) lights, so lets animate it

  ### Part 1
  from base grid, count numbers of lights on after n steps when
  - light on: 2-3 neighbours lights on, then turn the light off
  - light off: 3 neighbours lights on, stay off

  ### Part 2
  - just like part 1, but all 4 corners must be light on all the time
  """

  @steps 100

  @doc """
  Read the puzzle input file
  """
  def input do
    File.read!("priv/inputs/day18.txt")
  end

  @doc """
  wrapper around part1, reads the puzzle input and return the answer for part 1
  """
  def part1(), do: part1(input(), @steps)

  @doc """
  cleanup the input, put them into a map of `%({x, y}, state)`, gets `{max_x, max_y}` from `max_cords/1` and recursive the grid n times using `step/2`, return the number of turned on lights. 
  """
  def part1(input, steps) do
    grid =
      input
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {line, y}, acc ->
        line
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.reduce(acc, fn {char, x}, acc2 ->
          val =
            case char do
              "#" -> 1
              "." -> 0
            end

          Map.put(acc2, {x, y}, val)
        end)
      end)

    {max_x, max_y} = max_coords(grid)

    Enum.reduce(1..steps, grid, fn _, grid ->
      step(grid, {max_x, max_y})
    end)
    |> Enum.count(fn {_pos, val} -> val == 1 end)
  end

  @doc """
  wrapper around part2, reads the puzzle input and return the answer for part 2
  """
  def part2(), do: part2(input(), @steps)

  @doc """
  just like `part1/2`, but all 4 corners must be on every step
  """
  def part2(input, steps) do
    grid =
      input
      |> String.split("\n", trim: true)
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {line, y}, acc ->
        line
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.reduce(acc, fn {char, x}, acc2 ->
          val =
            case char do
              "#" -> 1
              "." -> 0
            end

          Map.put(acc2, {x, y}, val)
        end)
      end)

    {max_x, max_y} = max_coords(grid)

    grid =
      [{0, 0}, {max_x, 0}, {0, max_y}, {max_x, max_y}]
      |> Enum.reduce(grid, fn pos, acc -> Map.put(acc, pos, 1) end)

    Enum.reduce(1..steps, grid, fn _, grid ->
      new_grid = step(grid, {max_x, max_y})

      [{0, 0}, {max_x, 0}, {0, max_y}, {max_x, max_y}]
      |> Enum.reduce(new_grid, fn pos, acc -> Map.put(acc, pos, 1) end)
    end)
    |> Enum.count(fn {_pos, val} -> val == 1 end)
  end

  @doc """
  iterate through the 2d grid, checks number of lights turned on around it with `count_neighbours/3`, check the conditions and return a new map
  """

  def step(grid, {max_x, max_y}) do
    Enum.reduce(0..max_y, [], fn y, acc ->
      row = Enum.map(0..max_x, fn x -> {x, y} end)
      acc ++ row
    end)
    |> Enum.reduce(%{}, fn {x, y}, acc ->
      current = Map.get(grid, {x, y}, 0)
      count = count_neighbours(grid, x, y)

      temp =
        case {current, count} do
          {1, n} when n in 2..3 -> 1
          {0, 3} -> 1
          _ -> 0
        end

      Map.put(acc, {x, y}, temp)
    end)
  end

  defp count_neighbours(grid, x, y) do
    [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}]
    |> Enum.reduce(0, fn {dx, dy}, acc ->
      Map.get(grid, {x + dx, y + dy}, 0) + acc
    end)
  end

  defp max_coords(grid) do
    {{max_x, _}, _} = Enum.max_by(grid, fn {{x, _y}, _} -> x end)
    {{_, max_y}, _} = Enum.max_by(grid, fn {{_x, y}, _} -> y end)

    {max_x, max_y}
  end
end

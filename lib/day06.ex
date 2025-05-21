defmodule AOC2015.Day06 do
  @moduledoc """
  ## Day 6 - Probably a Fire Hazard

  santa sent you an instruciton for lights display, so you could beat your neighbours
  - turn on x1, y1 through x2, y2
  - turn off x1, y1 through x2, y2
  - toggle x1, y1 through x2, y2

  ### Part 1
  Do it as the instructions said, how many lights were turned on at the end

  ### Part 2
  whats the total brightness when
  - turn on means +1 brightness
  - turn off means -1 brightness
  - toggle means +2 brightness
  """
  @doc """
  read the puzzle input file
  """
  def input do
    File.read!("priv/inputs/day06.txt")
  end

  @doc """
  wrapper around part1, reads the puzzle input and return the answer for part 1
  """
  def part1(), do: part1(input())

  @doc """
  takes a list of instructions, do pattern matching on it (`parse_line/1`) then apply changes to erlang nested :array of `bool` and return number of lights on (`count_lights/1`)
  """
  def part1(input) do
    row = :array.new(size: 1000, default: false)
    grid = :array.new(size: 1000, default: row)

    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(grid, fn line, grid ->
      {action, {x1, y1}, {x2, y2}} = parse_line(line)

      Enum.reduce(x1..x2, grid, fn x, grid ->
        row = :array.get(x, grid)

        updated_row =
          Enum.reduce(y1..y2, row, fn y, row ->
            val = :array.get(y, row)

            new_val =
              case action do
                :on -> true
                :off -> false
                :toggle -> not val
              end

            :array.set(y, new_val, row)
          end)

        :array.set(x, updated_row, grid)
      end)
    end)
    |> count_lights()
  end

  @doc """
  wrapper around part2, reads the puzzle input and return the answer for part 1
  """
  def part2(), do: part2(input())

  @doc """
  takes a list of instructions, do pattern matching on it (`parse_line/1`) then apply changes to erlang nested :array of `int` and return number of lights on (`count_brightness/1`)
  """
  def part2(input) do
    row = :array.new(size: 1000, default: 0)
    grid = :array.new(size: 1000, default: row)

    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(grid, fn line, grid ->
      {action, {x1, y1}, {x2, y2}} = parse_line(line)

      Enum.reduce(x1..x2, grid, fn x, grid ->
        row = :array.get(x, grid)

        updated_row =
          Enum.reduce(y1..y2, row, fn y, row ->
            val = :array.get(y, row)

            increment =
              case action do
                :on -> 1
                :off -> -1
                :toggle -> 2
              end

            :array.set(y, max(val + increment, 0), row)
          end)

        :array.set(x, updated_row, grid)
      end)
    end)
    |> count_brightness()
  end

  defp parse_line(line) do
    cond do
      String.starts_with?(line, "turn on") ->
        ["turn", "on", from, "through", to] = String.split(line)
        {:on, parse_coordinates(from), parse_coordinates(to)}

      String.starts_with?(line, "turn off") ->
        ["turn", "off", from, "through", to] = String.split(line)
        {:off, parse_coordinates(from), parse_coordinates(to)}

      String.starts_with?(line, "toggle") ->
        ["toggle", from, "through", to] = String.split(line)
        {:toggle, parse_coordinates(from), parse_coordinates(to)}
    end
  end

  defp parse_coordinates(coord_str) do
    [x, y] = String.split(coord_str, ",") |> Enum.map(&String.to_integer/1)
    {x, y}
  end

  defp count_lights(grid) do
    Enum.reduce(0..999, 0, fn x, acc ->
      row = :array.get(x, grid)
      acc + Enum.count(0..999, fn y -> :array.get(y, row) end)
    end)
  end

  defp count_brightness(grid) do
    Enum.reduce(0..999, 0, fn x, acc ->
      row = :array.get(x, grid)

      row_sum =
        Enum.reduce(0..999, 0, fn y, acc_y ->
          acc_y + :array.get(y, row)
        end)

      acc + row_sum
    end)
  end
end

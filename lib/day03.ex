defmodule AOC2015.Day03 do
  @moduledoc """
  ## Day 03 - Perfectly Spherical Houses in a Vacuum

  santa deliver presents in a 2d grid, starting from (0, 0), when
  - '^' means go up (y + 1)
  - '>' means go right (x + 1)
  - 'v' means go down (y - 1)
  - '<' means go left (x - 1)

  ### Part 1
  santa moves around by the eggnogged elf instructions, find the number of houses he visits 

  ### Part 2
  now there's robo-santa that will take turns moving with santa, find the number of houses they visits. 
  """

  @doc """
  read the puzzle input file
  """
  def input do
    File.read!("priv/inputs/day03.txt")
  end

  @doc """
  wrapper around part1, reads the puzzle input and return the answer for part 1
  """
  def part1(), do: part1(input())

  @doc """
  returns santa visited node (mapset) size after all moves
  """
  def part1(input) do
    moves = String.graphemes(input)

    moves
    |> Enum.reduce({{0, 0}, MapSet.new([{0, 0}])}, fn dir, {{x, y}, visited} ->
      new_position =
        case dir do
          "^" -> {x, y + 1}
          ">" -> {x + 1, y}
          "v" -> {x, y - 1}
          "<" -> {x - 1, y}
          _ -> {x, y}
        end

      {new_position, MapSet.put(visited, new_position)}
    end)
    |> then(fn {_pos, visited} -> MapSet.size(visited) end)
  end

  @doc """
  wrapper around part2, reads the puzzle input and return the answer for part 2
  """
  def part2(), do: part2(input())

  @doc """
  returns santa and robo-santa visited node (mapset) size after all moves
  """

  def part2(input) do
    moves = String.graphemes(input)

    moves
    |> Enum.reduce({{0, 0}, {0, 0}, MapSet.new([{0, 0}]), :santa}, fn dir,
                                                                      {{x1, y1}, {x2, y2},
                                                                       visited, state} ->
      case state do
        :santa ->
          new_position = move(dir, {x1, y1})
          {new_position, {x2, y2}, MapSet.put(visited, new_position), :robo_santa}

        :robo_santa ->
          new_position = move(dir, {x2, y2})
          {{x1, y1}, new_position, MapSet.put(visited, new_position), :santa}
      end
    end)
    |> then(fn {{_x1, _y1}, {_x2, _y2}, visited, _state} -> MapSet.size(visited) end)
  end

  defp move(">", {x, y}), do: {x + 1, y}
  defp move("<", {x, y}), do: {x - 1, y}
  defp move("^", {x, y}), do: {x, y + 1}
  defp move("v", {x, y}), do: {x, y - 1}
  defp move(_, pos), do: pos
end

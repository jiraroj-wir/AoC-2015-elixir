defmodule AOC2015.Day03 do
  @moduledoc """

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

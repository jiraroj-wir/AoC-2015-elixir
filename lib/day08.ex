defmodule AOC2015.Day08 do
  @doc """
  read the puzzle input file
  """
  def input do
    File.read!("priv/inputs/day08.txt")
  end

  @doc """
  wrapper around part1, reads the puzzle input and return the answer for part 1
  """
  def part1(), do: part1(input())

  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn line, diff ->
      string_code =
        line
        |> String.to_charlist()
        |> Enum.reduce(0, fn _ch, acc -> acc + 1 end)

      string_values =
        line
        |> String.to_charlist()
        |> count_char(0)

      diff + (string_code - string_values)
    end)
  end

  defp count_char([], acc), do: acc

  defp count_char([?\\, ?x, _a, _b | rest], acc),
    do: count_char(rest, acc + 1)

  defp count_char([?\\, _ | rest], acc),
    do: count_char(rest, acc + 1)

  defp count_char([?" | rest], acc),
    do: count_char(rest, acc)

  defp count_char([_ | rest], acc),
    do: count_char(rest, acc + 1)
end

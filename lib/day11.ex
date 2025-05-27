defmodule AOC2015.Day11 do
  @moduledoc """
  ## Day 11 - Corporate Policy

  help santa finds new password that satisfy these rules by incrementing the initial password
  - have increasing straight of at least 3 letters
  - dont contain letters 'i', 'o', 'l'
  - have at least two of the same character pair

  ### Part 1
  find the new password

  ### Part 2
  find the new new password, using part 1's password
  """

  @doc """
  Read the puzzle input file.
  """
  def input do
    File.read!("priv/inputs/day11.txt")
  end

  @doc """
  Wrapper around part1, reads the puzzle input and returns the answer for part 1.
  """
  def part1(), do: part1(input())

  @doc """
  clean the data, then iterate by `increment/1` and find the `valid/1` password, return its string
  """
  def part1(input) do
    input
    |> String.trim()
    |> String.to_charlist()
    |> Stream.iterate(&increment/1)
    |> Enum.find(&valid?/1)
    |> to_string()
  end

  @doc """
  part1(part1()) 
  """
  def part2() do
    part1()
    |> String.trim()
    |> String.to_charlist()
    |> increment()
    |> to_string()
    |> part1()
  end

  @doc """
  increment the password, since list in elixir is a linked list, we reverse the list first for an O(1) `prepend` operation. This gives a more constant time of O(3n) rather than O(kn) ; k is the the times we pass value to the next digit - though most of the time, k would be 1
  """
  def increment(password) do
    password
    |> Enum.reverse()
    |> do_increment()
    |> Enum.reverse()
    |> skip_forbidden()
  end

  defp do_increment([]), do: [?a]
  defp do_increment([?z | rest]), do: [?a | do_increment(rest)]
  defp do_increment([h | rest]), do: [h + 1 | rest]

  defp skip_forbidden(password) do
    case Enum.split_while(password, fn ch -> ch not in [?i, ?o, ?l] end) do
      {ok, [bad | rest]} ->
        fixed = ok ++ [bad + 1] ++ List.duplicate(?a, length(rest))
        skip_forbidden(fixed)

      {ok, []} ->
        ok
    end
  end

  @doc """
  check if the password is valid or not, these things must be true
  - `has_three_letter_straight?/1` : check for 3 letter straight
  - `not_contain_iol?/1` : check that the list doesn't contain i, o and l
  - `tow_pair?/1` : there should be two pair of repeated chearacter
  """
  def valid?(password) do
    has_three_letter_straight?(password) and
      not_contain_iol?(password) and
      two_pair?(password)
  end

  defp has_three_letter_straight?([a, b, c | _rest]) when b == a + 1 and c == a + 2, do: true
  defp has_three_letter_straight?([_ | rest]), do: has_three_letter_straight?(rest)
  defp has_three_letter_straight?(_), do: false

  defp not_contain_iol?(password) do
    not Enum.any?(password, &(&1 in [?i, ?o, ?l]))
  end

  defp two_pair?([a, a | rest]), do: second_pair?(rest, a)
  defp two_pair?([_ | rest]), do: two_pair?(rest)
  defp two_pair?([]), do: false

  defp second_pair?([b, b | _], a) when b != a, do: true
  defp second_pair?([_ | rest], a), do: second_pair?(rest, a)
  defp second_pair?([], _), do: false
end

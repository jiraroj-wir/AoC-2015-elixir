defmodule AOC2015.Day07 do
  import Bitwise

  @doc """
  read the puzzle input file
  """
  def input do
    File.read!("priv/inputs/day07.txt")
  end

  @doc """
  wrapper around part1, reads the puzzle input and return the answer for part 1
  """
  def part1(), do: part1(input(), "a")

  def part1(input, target) do
    instruction_map =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [expr, target] = String.split(line, " -> ", trim: true)
        {String.trim(target), String.trim(expr)}
      end)
      |> Map.new()

    {value, _cache} = lazy_evaluate(instruction_map, target)
    value
  end

  @doc """
  wrapper around part2, reads the puzzle input and return the answer for part 2
  """
  def part2(), do: part2(input(), "a")

  def part2(input, target) do
    signal_a = part1()

    instruction_map =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [expr, target] = String.split(line, " -> ", trim: true)
        {String.trim(target), String.trim(expr)}
      end)
      |> Map.new()

    instruction_map = Map.put(instruction_map, "b", Integer.to_string(signal_a))

    {value, _cache} = lazy_evaluate(instruction_map, target)
    value
  end

  def lazy_evaluate(instructions, wire, cache \\ %{}) do
    cond do
      is_number_literal(wire) ->
        {String.to_integer(wire), cache}

      Map.has_key?(cache, wire) ->
        {Map.get(cache, wire), cache}

      true ->
        expr = Map.fetch!(instructions, wire)
        {value, new_cache} = evaluate_expression(expr, instructions, cache)
        {value, Map.put(new_cache, wire, value)}
    end
  end

  defp is_number_literal(str) do
    case Integer.parse(str) do
      {_, ""} -> true
      _ -> false
    end
  end

  defp evaluate_expression(expr, instructions, cache) do
    parts = String.split(expr, " ")

    case parts do
      [a] ->
        lazy_evaluate(instructions, a, cache)

      ["NOT", x] ->
        {val, c} = lazy_evaluate(instructions, x, cache)
        {~~~val &&& 0xFFFF, c}

      [a, "AND", b] ->
        {va, c1} = lazy_evaluate(instructions, a, cache)
        {vb, c2} = lazy_evaluate(instructions, b, c1)
        {va &&& vb, c2}

      [a, "OR", b] ->
        {va, c1} = lazy_evaluate(instructions, a, cache)
        {vb, c2} = lazy_evaluate(instructions, b, c1)
        {va ||| vb, c2}

      [a, "LSHIFT", n] ->
        {va, c} = lazy_evaluate(instructions, a, cache)
        {va <<< String.to_integer(n), c}

      [a, "RSHIFT", n] ->
        {va, c} = lazy_evaluate(instructions, a, cache)
        {va >>> String.to_integer(n), c}
    end
  end
end

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

  @doc """
  takes a list of instructions, split and map them, then call `memoized_recursion/2`, which in the end should return wire signal value for target
  """
  def part1(input, target) do
    instruction_map =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [expr, target] = String.split(line, " -> ", trim: true)
        {String.trim(target), String.trim(expr)}
      end)
      |> Map.new()

    {value, _cache} = memoized_recursion(instruction_map, target)
    value
  end

  @doc """
  wrapper around part2, reads the puzzle input and return the answer for part 2
  """
  def part2(), do: part2(input(), "a")

  @doc """
  same as `part1/2`, just run `part1/2` first for `signal_a`, then replace expr of wire `b` with `signal_a` and call `memoized_recursion/2` - just like `part1/2`
  """
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

    {value, _cache} = memoized_recursion(instruction_map, target)
    value
  end

  @doc """
  the main idea here is to recursively find the root expression that forms a target `wire`. 
  so, you check if the target `wire`'s expression in the `instructions` map or the `cache` map is a number or not. 
  if so, just return it. otherwise, you need to find the value of the `wire` in the expression that forms its value.
  """
  def memoized_recursion(instructions, wire, cache \\ %{}) do
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
        memoized_recursion(instructions, a, cache)

      ["NOT", x] ->
        {val, c} = memoized_recursion(instructions, x, cache)
        {~~~val &&& 0xFFFF, c}

      [a, "AND", b] ->
        {va, c1} = memoized_recursion(instructions, a, cache)
        {vb, c2} = memoized_recursion(instructions, b, c1)
        {va &&& vb, c2}

      [a, "OR", b] ->
        {va, c1} = memoized_recursion(instructions, a, cache)
        {vb, c2} = memoized_recursion(instructions, b, c1)
        {va ||| vb, c2}

      [a, "LSHIFT", n] ->
        {va, c} = memoized_recursion(instructions, a, cache)
        {va <<< String.to_integer(n), c}

      [a, "RSHIFT", n] ->
        {va, c} = memoized_recursion(instructions, a, cache)
        {va >>> String.to_integer(n), c}
    end
  end
end

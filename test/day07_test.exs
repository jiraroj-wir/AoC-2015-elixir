defmodule AOC2015.Day07Test do
  use ExUnit.Case
  alias AOC2015.Day07

  describe "part1/1" do
    test "returns each wire signal" do
      input = """
        123 -> x
        456 -> y
        x AND y -> d
        x OR y -> e
        x LSHIFT 2 -> f
        y RSHIFT 2 -> g
        NOT x -> h
        NOT y -> i
      """

      assert Day07.part1(input, "d") == 72
      assert Day07.part1(input, "e") == 507
      assert Day07.part1(input, "f") == 492
      assert Day07.part1(input, "g") == 114
      assert Day07.part1(input, "h") == 65412
      assert Day07.part1(input, "i") == 65079
      assert Day07.part1(input, "x") == 123
      assert Day07.part1(input, "y") == 456
    end
  end

  describe "part2/1" do
    test "returns each wire signal" do
    end
  end
end

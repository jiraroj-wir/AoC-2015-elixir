defmodule AOC2015.Day10Test do
  use ExUnit.Case
  alias AOC2015.Day10

  describe "part1/1" do
    test "returns the length of result of look and say n times" do
      assert Day10.part1("211", 1) == 4
      assert Day10.part1("1", 1) == 2
      assert Day10.part1("11", 1) == 2
      assert Day10.part1("21", 1) == 4
      assert Day10.part1("1211", 1) == 6
      assert Day10.part1("111221", 1) == 6
      assert Day10.part1("1", 5) == 6
    end
  end

  describe "part2/1" do
    test "same as part1/1, just do it 50 times, and find the length" do
    end
  end
end

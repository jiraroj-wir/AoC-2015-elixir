defmodule AOC2015.Day01Test do
  use ExUnit.Case
  alias AOC2015.Day01

  describe "part1/1" do
    test "returns final floor" do
      assert Day01.part1("(())") == 0
      assert Day01.part1("()()") == 0
      assert Day01.part1("(((") == 3
      assert Day01.part1("(()(()(") == 3
      assert Day01.part1("))(((((") == 3
      assert Day01.part1("())") == -1
      assert Day01.part1("))(") == -1
      assert Day01.part1(")))") == -3
      assert Day01.part1(")())())") == -3
    end
  end

  describe "part2/1" do
    test "returns index where Santa enters basement" do
      assert Day01.part2(")") == 1
      assert Day01.part2("()())") == 5
    end
  end
end

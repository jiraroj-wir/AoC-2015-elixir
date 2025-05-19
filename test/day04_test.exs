defmodule AOC2015.Day04Test do
  use ExUnit.Case
  alias AOC2015.Day04

  describe "part1/1" do
    test "returns the first number that starts with '00000' when hash with MD5" do
      assert Day04.part1("abcdef") == 609_043
      assert Day04.part1("pqrstuv") == 1_048_970
    end
  end

  describe "part2/1" do
    test "returns the first number that starts with '000000' when hash with MD5" do
    end
  end
end

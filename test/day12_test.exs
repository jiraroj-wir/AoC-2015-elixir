defmodule AOC2015.Day12Test do
  use ExUnit.Case
  alias AOC2015.Day12

  describe "part1/1" do
    test "returns the sum of all numbers in a string" do
      assert Day12.part1("[1,2,3]") == 6
      assert Day12.part1("{\"a\":2,\"b\":4}") == 6
      assert Day12.part1("[[[3]]]") == 3
      assert Day12.part1("{\"a\":{\"b\":4},\"c\":-1}") == 3
      assert Day12.part1("{\"a\":[-1,1]}") == 0
      assert Day12.part1("[-1,{\"a\":1}]") == 0
      assert Day12.part1("[]") == 0
      assert Day12.part1("{}") == 0
    end
  end

  """
    describe "part2/1" do
      test "returns the first number that starts with '000000' when hash with MD5" do
      end
    end
  """
end

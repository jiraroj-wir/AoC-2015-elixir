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

  describe "part2/1" do
    test "returns the sum ignoring any object with 'red'" do
      assert Day12.part2("[1,2,3]") == 6
      assert Day12.part2("[1,{\"c\":\"red\",\"b\":2},3]") == 4
      assert Day12.part2("{\"d\":\"red\",\"e\":[1,2,3,4],\"f\":5}") == 0
      assert Day12.part2("[1,\"red\",5]") == 6
    end
  end
end

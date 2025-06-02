defmodule AOC2015.Day15Test do
  use ExUnit.Case
  alias AOC2015.Day15

  describe "part1/1" do
    test "returns the best proportion - the ones that gives the maximum score" do
      input = ~S"""
      Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
      Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3
      """

      assert Day15.part1(input) == 62_842_880
    end
  end

  describe "part2/1" do
    test "returns the best proportion that gives 500 calories" do
      input = ~S"""
      Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
      Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3
      """

      assert Day15.part2(input) == 57_600_000
    end
  end
end

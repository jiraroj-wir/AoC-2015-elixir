defmodule AOC2015.Day09Test do
  use ExUnit.Case
  alias AOC2015.Day09

  describe "part1/1" do
    test "returns the shortest route that pass through every cities" do
      input = """
      London to Dublin = 464
      London to Belfast = 518
      Dublin to Belfast = 141
      """

      assert Day09.part1(input) == 605
    end
  end

  describe "part2/1" do
    test "returns index where Santa enters basement" do
      input = """
      London to Dublin = 464
      London to Belfast = 518
      Dublin to Belfast = 141
      """

      assert Day09.part2(input) == 982
    end
  end
end

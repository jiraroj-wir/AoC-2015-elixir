defmodule AOC2015.Day24Test do
  use ExUnit.Case
  alias AOC2015.Day24

  describe "part1/1" do
    test "returns minimum quantum entanglement of the passenger compartment, when theres 3 groups" do
      input = ~S"""
      1
      2
      3
      4
      5
      7
      8
      9
      10
      11
      """

      assert Day24.part1(input) == 99
    end
  end

  describe "part2/1" do
    test "returns minimum quantum entanglement of the passenger compartment, when there are 4 groups" do
      input = ~S"""
      1
      2
      3
      4
      5
      7
      8
      9
      10
      11
      """

      assert Day24.part2(input) == 44
    end
  end
end

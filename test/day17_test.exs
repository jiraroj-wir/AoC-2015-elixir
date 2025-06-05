defmodule AOC2015.Day17Test do
  use ExUnit.Case
  alias AOC2015.Day17

  describe "part1/2" do
    test "returns amount of possible combinations" do
      input = ~S"""
        20
        15
        10
        5
        5
      """

      assert Day17.part1(input, 25) == 4
    end
  end

  describe "part2/2" do
    test "returns amount of possible combinations that usus minimum containers" do
      input = ~S"""
        20
        15
        10
        5
        5
      """

      assert Day17.part2(input, 25) == 3
    end
  end
end

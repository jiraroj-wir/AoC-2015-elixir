defmodule AOC2015.Day14Test do
  use ExUnit.Case
  alias AOC2015.Day14

  describe "part1/2" do
    test "returns the winning raindeer distance after a given time" do
      input = ~S"""
      Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
      Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.
      """

      assert Day14.part1(input, 1000) == 1120
    end
  end

  describe "part2/2" do
    test "returns the winning raindeer points after a given time (rule changed)" do
      input = ~S"""
      Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
      Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.
      """

      assert Day14.part2(input, 1000) == 689
    end
  end
end

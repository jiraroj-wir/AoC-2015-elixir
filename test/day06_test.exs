defmodule AOC2015.Day06Test do
  use ExUnit.Case
  alias AOC2015.Day06

  describe "part1/1" do
    test "return number of lights turn on" do
      assert Day06.part1("turn on 0,0 through 999,999") == 1_000_000
      assert Day06.part1("toggle 0,0 through 999,0") == 1000
      assert Day06.part1("turn off 499,499 through 500,500") == 0
    end
  end

  describe "part2/1" do
    test "return total brightness" do
      assert Day06.part2("turn on 0,0 through 0,0") == 1
      assert Day06.part2("toggle 0,0 through 999,999") == 2_000_000
    end
  end
end

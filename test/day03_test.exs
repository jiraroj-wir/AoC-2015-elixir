defmodule AOC2015.Day03Test do
  use ExUnit.Case
  alias AOC2015.Day03

  describe "part1/1" do
    test "return number of houses that get at least one present" do
      assert Day03.part1(">") == 2
      assert Day03.part1("^>v<") == 4
      assert Day03.part1("^v^v^v^v^v ") == 2
    end
  end

  describe "part2/1" do
    test "return number of housed that get at least one present by santa or robo-santa" do
      assert Day03.part2("^v") == 3
      assert Day03.part2("^>v<") == 3
      assert Day03.part2("^v^v^v^v^v") == 11
    end
  end
end

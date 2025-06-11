defmodule AOC2015.Day23Test do
  use ExUnit.Case
  alias AOC2015.Day23

  describe "part1/1" do
    test "from the given example, running this should set a to 2, and b to 0" do
      input = ~S"""
      inc a
      jio a, +2
      tpl a
      inc a
      """

      assert Day23.part1(input) == 0
    end
  end
end

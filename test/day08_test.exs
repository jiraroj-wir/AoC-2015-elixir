defmodule AOC2015.Day08Test do
  use ExUnit.Case
  alias AOC2015.Day08

  describe "part1/1" do
    test "returns the difference between code and memory representation" do
      assert Day08.part1("\"\"\n") == 2
      assert Day08.part1("\"abc\"\n") == 2
      assert Day08.part1("\"aaa\\\"aaa\"\n") == 3
      assert Day08.part1("\"\\x27\"\n") == 5
    end
  end

  """
  describe "part2/1" do
    test "return total brightness" do
      assert Day06.part2("turn on 0,0 through 0,0") == 1
      assert Day06.part2("toggle 0,0 through 999,999") == 2_000_000
    end
  end
  """
end

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

  describe "part2/1" do
    test "return the difference between number of character in the newly encoded string and the initial ones" do
      assert Day08.part2("\"\"\n") == 4
      assert Day08.part2("\"abc\"\n") == 4
      assert Day08.part2("\"aaa\\\"aaa\"\n") == 6
      assert Day08.part2("\"\\x27\"\n") == 5
    end
  end
end

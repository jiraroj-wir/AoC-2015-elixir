defmodule AOC2015.Day05Test do
  use ExUnit.Case
  alias AOC2015.Day05

  describe "part1/1" do
    test "return amount of nice string on the part1 criteria" do
      assert Day05.part1("ugknbfddgicrmopn") == 1
      assert Day05.part1("aaa") == 1
      assert Day05.part1("jchzalrnumimnmhp") == 0
      assert Day05.part1("haegwjzuvuyypxyu") == 0
      assert Day05.part1("dvszwmarrgswjxmb") == 0
    end
  end

  describe "part2/1" do
    test "return amount of nice string on the part2 criteria" do
      assert Day05.part2("qjhvhtzxzqqjkmpb") == 1
      assert Day05.part2("xxyxx") == 1
      assert Day05.part2("uurcxstgmygtbstg") == 0
      assert Day05.part2("ieodomkazucvgmuy") == 0
    end
  end
end

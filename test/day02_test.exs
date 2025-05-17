defmodule AOC2015.Day02Test do
  use ExUnit.Case
  alias AOC2015.Day02

  describe "part1/1" do
    test "returns total wrapping paper's area" do
      assert Day02.part1("2x3x4") == 58
      assert Day02.part1("1x1x10") == 43
    end
  end

  """
  describe "part2/1" do
    test "returns index where Santa enters basement" do
    end
  end
  """
end

defmodule AOC2015.Day19Test do
  use ExUnit.Case
  alias AOC2015.Day19

  describe "part1/2" do
    test "returns numbers of new molecules" do
      input_1 = """
      H => HO
      H => OH
      O => HH

      HOH
      """

      input_2 = """
      H => HO
      H => OH
      O => HH
          
      HOHOHO
      """

      assert Day19.part1(input_1) == 4
      assert Day19.part1(input_2) == 7
    end
  end

  describe "part2/2" do
    test "returns steps needed to construct target molecule from a single e-" do
      input_1 = """
      e => H
      e => O
      H => HO
      H => OH
      O => HH

      HOH
      """

      input_2 = """
      e => H
      e => O
      H => HO
      H => OH
      O => HH

      HOHOHO
      """

      assert Day19.part2(input_1) == 3
      assert Day19.part2(input_2) == 6
    end
  end
end

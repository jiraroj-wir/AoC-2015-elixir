defmodule AOC2015.Day25Test do
  use ExUnit.Case
  alias AOC2015.Day25

  describe "part1/1" do
    test "returns correct code at specific grid positions" do
      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 1, column 1."
             ) == 20_151_125

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 1, column 2."
             ) == 18_749_137

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 1, column 3."
             ) == 17_289_845

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 1, column 4."
             ) == 30_943_339

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 1, column 5."
             ) == 10_071_777

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 1, column 6."
             ) == 33_511_524

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 2, column 1."
             ) == 31_916_031

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 2, column 2."
             ) == 21_629_792

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 2, column 3."
             ) == 16_929_656

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 2, column 4."
             ) == 7_726_640

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 2, column 5."
             ) == 15_514_188

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 2, column 6."
             ) == 4_041_754

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 3, column 1."
             ) == 16_080_970

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 3, column 2."
             ) == 8_057_251

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 3, column 3."
             ) == 1_601_130

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 3, column 4."
             ) == 7_981_243

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 3, column 5."
             ) == 11_661_866

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 3, column 6."
             ) == 16_474_243

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 4, column 1."
             ) == 24_592_653

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 4, column 2."
             ) == 32_451_966

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 4, column 3."
             ) == 21_345_942

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 4, column 4."
             ) == 9_380_097

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 4, column 5."
             ) == 10_600_672

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 4, column 6."
             ) == 31_527_494

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 5, column 1."
             ) == 77061

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 5, column 2."
             ) == 17_552_253

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 5, column 3."
             ) == 28_094_349

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 5, column 4."
             ) == 6_899_651

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 5, column 5."
             ) == 9_250_759

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 5, column 6."
             ) == 31_663_883

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 6, column 1."
             ) == 33_071_741

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 6, column 2."
             ) == 6_796_745

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 6, column 3."
             ) == 25_397_450

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 6, column 4."
             ) == 24_659_492

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 6, column 5."
             ) == 1_534_922

      assert Day25.part1(
               "To continue, please consult the code grid in the manual. Enter the code at row 6, column 6."
             ) == 27_995_004
    end
  end
end

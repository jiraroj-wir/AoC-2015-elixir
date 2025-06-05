defmodule AOC2015.Day18Test do
  use ExUnit.Case
  alias AOC2015.Day18

  describe "part1/2" do
    test "returns how many lights were on after n steps" do
      input = ~S"""
      .#.#.#
      ...##.
      #....#
      ..#...
      #.#..#
      ####..
      """

      _first_iter = ~S"""
      ..##..
      ..##.#
      ...##.
      ......
      #.....
      #.##..
      """

      _second_iter = ~S"""
      ..###.
      ......
      ..###.
      ......
      .#....
      .#....
      """

      _third_iter = ~S"""
      ...#..
      ......
      ...#..
      ..##..
      ......
      ......
      """

      _fourth_iter = ~S"""
      ......
      ......
      ..##..
      ..##..
      ......
      ......
      """

      assert Day18.part1(input, 1) == 11
      assert Day18.part1(input, 2) == 8
      assert Day18.part1(input, 3) == 4
      assert Day18.part1(input, 4) == 4
    end
  end

  describe "part2/2" do
    test "returns how many lights were on after n steps with 4 corners always turned on" do
      input = ~S"""
      .#.#.#
      ...##.
      #....#
      ..#...
      #.#..#
      ####..
      """

      _first_iter = ~S"""
      #.##.#
      ####.#
      ...##.
      ......
      #...#.
      #.####
      """

      _second_iter = ~S"""
      #..#.#
      #....#
      .#.##.
      ...##.
      .#..##
      ##.###
      """

      _third_iter = ~S"""
      #...##
      ####.#
      ..##.#
      ......
      ##....
      ####.#
      """

      _fourth_iter = ~S"""
      #.####
      #....#
      ...#..
      .##...
      #.....
      #.#..#
      """

      _fifth_iter = ~S"""
      ##.###
      .##..#
      .##...
      .##...
      #.#...
      ##...#
      """

      assert Day18.part2(input, 1) == 18
      assert Day18.part2(input, 2) == 18
      assert Day18.part2(input, 3) == 18
      assert Day18.part2(input, 4) == 14
      assert Day18.part2(input, 5) == 17
    end
  end
end

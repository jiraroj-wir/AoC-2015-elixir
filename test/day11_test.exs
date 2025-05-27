defmodule AOC2015.Day11Test do
  use ExUnit.Case
  alias AOC2015.Day11

  describe "valid?/1" do
    test "hijklmmn - has straight, but contains i and l" do
      assert Day11.valid?(~c"hijklmmn") == false
    end

    test "abbceffg - has two pairs, but no straight" do
      assert Day11.valid?(~c"abbceffg") == false
    end

    test "abbcegjk - has straight, but only one pair" do
      assert Day11.valid?(~c"abbcegjk") == false
    end

    test "abcdffaa - valid password" do
      assert Day11.valid?(~c"abcdffaa") == true
    end

    test "ghjaabcc - valid password" do
      assert Day11.valid?(~c"ghjaabcc") == true
    end
  end

  describe "part1/1" do
    test "next valid password from abcdefgh is abcdffaa" do
      assert Day11.part1("abcdefgh") == "abcdffaa"
    end

    test "next valid password from ghijklmn is ghjaabcc" do
      assert Day11.part1("ghijklmn") == "ghjaabcc"
    end
  end
end

defmodule AOC2015.Day21 do
  @moduledoc """
  ## Day 21 - RPG Simulator 20XX

  every items from the shop, you equipt 1 weapon, 0-1 armor and 0-2 ring/s, fight the boss in turns

  ### Part 1
  wins with the least amount of coin usage

  ### Part 2
  lost with the greatest amount of coin usage
  """

  @doc """
  read the puzzle input file
  """
  def input do
    File.read!("priv/inputs/day21.txt")
  end

  defmodule Item do
    @moduledoc """
    each item's stats: name, cost, damage and armor
    """
    defstruct name: "", cost: 0, damage: 0, armor: 0
  end

  defmodule Entity do
    @moduledoc """
    each entity's (player and boss) stat: hit point, damage and armor
    """
    defstruct hp: 0, damage: 0, armor: 0
  end

  @doc """
  lists of `%Item` of `weapons`, `armors` and `rings`
  """
  def shop do
    weapons = [
      %Item{name: "Dagger", cost: 8, damage: 4, armor: 0},
      %Item{name: "Shortsword", cost: 10, damage: 5, armor: 0},
      %Item{name: "Warhammer", cost: 25, damage: 6, armor: 0},
      %Item{name: "Longsword", cost: 40, damage: 7, armor: 0},
      %Item{name: "Greataxe", cost: 74, damage: 8, armor: 0}
    ]

    armors = [
      %Item{name: "None", cost: 0, damage: 0, armor: 0},
      %Item{name: "Leather", cost: 13, damage: 0, armor: 1},
      %Item{name: "Chainmail", cost: 31, damage: 0, armor: 2},
      %Item{name: "Splintmail", cost: 53, damage: 0, armor: 3},
      %Item{name: "Bandedmail", cost: 75, damage: 0, armor: 4},
      %Item{name: "Platemail", cost: 102, damage: 0, armor: 5}
    ]

    rings = [
      %Item{name: "Damage +1", cost: 25, damage: 1, armor: 0},
      %Item{name: "Damage +2", cost: 50, damage: 2, armor: 0},
      %Item{name: "Damage +3", cost: 100, damage: 3, armor: 0},
      %Item{name: "Defense +1", cost: 20, damage: 0, armor: 1},
      %Item{name: "Defense +2", cost: 40, damage: 0, armor: 2},
      %Item{name: "Defense +3", cost: 80, damage: 0, armor: 3}
    ]

    {weapons, armors, rings}
  end

  @doc """
  wrapper around part1, reads the puzzle input and return the answer for part 1
  """
  def part1(), do: part1(input())

  @doc """
  after reading the boss's stats into `%Entity`, create all combinations with `all_combinations/1`, `calc_stats_and_cost/1`, sort it, find the first one that win with `win?` and returns it.
  """
  def part1(input) do
    boss =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [k, v] = String.split(line, ": ")

        key =
          case k do
            "Hit Points" -> :hp
            "Damage" -> :damage
            "Armor" -> :armor
          end

        {key, String.to_integer(v)}
      end)
      |> Enum.into(%{})
      |> then(&struct(Entity, &1))

    shop()
    |> all_combinations()
    |> Enum.map(&calc_stats_and_cost/1)
    |> Enum.sort_by(& &1.cost)
    |> Enum.find(fn %{player: player} -> win?(player, boss) end)
    |> Map.get(:cost)
  end

  @doc """
  wrapper around part2, reads the puzzle input and return the answer for part 2
  """
  def part2(), do: part2(input())

  @doc """
  just like `part1/1`, but we sort it in reverse (reverse the list with `Enum.reverse()`) and find the first one that lost, returns it.
  """
  def part2(input) do
    boss =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [k, v] = String.split(line, ": ")

        key =
          case k do
            "Hit Points" -> :hp
            "Damage" -> :damage
            "Armor" -> :armor
          end

        {key, String.to_integer(v)}
      end)
      |> Enum.into(%{})
      |> then(&struct(Entity, &1))

    shop()
    |> all_combinations()
    |> Enum.map(&calc_stats_and_cost/1)
    |> Enum.sort_by(& &1.cost)
    |> Enum.reverse()
    |> Enum.find(fn %{player: player} -> not win?(player, boss) end)
    |> Map.get(:cost)
  end

  defp all_combinations({weapons, armors, rings}) do
    ring_sets =
      [[]] ++
        Enum.map(rings, &[&1]) ++
        for {r1, i1} <- Enum.with_index(rings),
            {r2, i2} <- Enum.with_index(rings),
            i1 < i2,
            do: [r1, r2]

    weapons
    |> Enum.flat_map(fn w ->
      armors
      |> Enum.flat_map(fn a ->
        ring_sets
        |> Enum.map(fn r ->
          [w, a | r]
        end)
      end)
    end)
  end

  defp win?(player, boss) do
    player_dmg = max(player.damage - boss.armor, 1)
    boss_dmg = max(boss.damage - player.armor, 1)

    player_turns = div_ceil(boss.hp, player_dmg)
    boss_turns = div_ceil(player.hp, boss_dmg)

    player_turns <= boss_turns
  end

  defp calc_stats_and_cost(items) do
    total =
      Enum.reduce(items, %Item{}, fn item, acc ->
        %Item{
          cost: acc.cost + item.cost,
          damage: acc.damage + item.damage,
          armor: acc.armor + item.armor
        }
      end)

    player = %Entity{hp: 100, damage: total.damage, armor: total.armor}
    %{cost: total.cost, player: player}
  end

  defp div_ceil(a, b), do: div(a + b - 1, b)
end

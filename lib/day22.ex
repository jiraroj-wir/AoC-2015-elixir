defmodule AOC2015.Day22 do
  @moduledoc """
  ## Day 22 - Wizard Simulator 20XX

  you change from meal combat to using magic instead, so theres mana, healing and poison involved

  ### Part 1
  easy mode - take turn with boss, you can use any spell, die when health point reach 0 or ran out of mana, returns the lowest mana usage to win

  ### Part 2
  just like part 1, but this time, hp -1 every turns
  """

  @doc """
  read the puzzle input file
  """
  def input, do: File.read!("priv/inputs/day22.txt")

  defmodule Entity do
    @moduledoc """
    a struct representing either the player or boss, with `:hp` and `:damage`
    """
    defstruct hp: 0, damage: 0
  end

  defmodule Spell do
    @moduledoc """
    a struct for spell metadata: `:name`, `:cost`, and optional effects like `:damage`, `:heal`, `:shield`, `:poison`, or `:mana`
    """
    defstruct name: "", cost: 0, damage: 0, heal: 0, shield: 0, poison: 0, mana: 0
  end

  defmodule State do
    @moduledoc """
    represents the full simulation state: includes `:player`, `:boss`, remaining `:mana`, `:mana_spent`, `:armor`, current `:effects`, and whose `:turn` it is
    """
    defstruct player: nil,
              boss: nil,
              mana: 500,
              mana_spent: 0,
              armor: 0,
              effects: %{shield: 0, poison: 0, recharge: 0},
              turn: :player,
              mode: :normal
  end

  @doc """
  returns the list of available `%Spell{}` used in the fight
  """
  def magic do
    [
      %Spell{name: "Magic Missile", cost: 53, damage: 4},
      %Spell{name: "Drain", cost: 73, damage: 2, heal: 2},
      %Spell{name: "Shield", cost: 113, shield: 6},
      %Spell{name: "Poison", cost: 173, poison: 6},
      %Spell{name: "Recharge", cost: 229, mana: 5}
    ]
  end

  @doc """
  wrapper around part1, reads the puzzle input and return the answer for part 1
  """
  def part1(), do: part1(input())

  @doc """
  after parsing the boss's stats into `%Entity`, calls `simulate/3` in `:normal` mode to find the minimum mana spent to win
  """
  def part1(input) do
    boss =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn
        "Hit Points: " <> v -> {:hp, String.to_integer(v)}
        "Damage: " <> v -> {:damage, String.to_integer(v)}
      end)
      |> Enum.into(%{})
      |> then(&struct(Entity, &1))

    simulate(magic(), boss, :normal)
  end

  @doc """
  wrapper around part2, reads the puzzle input and return the answer for part 2
  """
  def part2(), do: part2(input())

  @doc """
  same as `part1/1`, but calls `simulate/3` in `:hard` mode (lose 1 hp per player turn)
  """
  def part2(input) do
    boss =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn
        "Hit Points: " <> v -> {:hp, String.to_integer(v)}
        "Damage: " <> v -> {:damage, String.to_integer(v)}
      end)
      |> Enum.into(%{})
      |> then(&struct(Entity, &1))

    simulate(magic(), boss, :hard)
  end

  @doc """
  simulates the entire fight using `dfs/4`, starting with the given `boss`, list of `spells`, and mode (`:normal` or `:hard`)
  """
  def simulate(spells, boss, mode \\ :normal) do
    start = %State{player: %Entity{hp: 50}, boss: boss, mode: mode}
    dfs(start, :infinity, spells, %{})
  end

  defp dfs(state, best, _spells, _seen) when state.player.hp <= 0, do: best
  defp dfs(%State{mana_spent: spent}, best, _spells, _seen) when spent >= best, do: best
  defp dfs(state, best, _spells, _seen) when state.boss.hp <= 0, do: min(state.mana_spent, best)

  defp dfs(state, best, spells, seen) do
    key = snapshot(state)

    case seen do
      %{^key => prev} when prev <= state.mana_spent ->
        best

      _ ->
        seen1 = Map.put(seen, key, state.mana_spent)
        step(state, best, spells, seen1)
    end
  end

  defp step(%State{turn: :player} = state, best, spells, seen) do
    state
    |> hard_mode_penalty()
    |> case do
      %State{player: %{hp: hp}} = _s when hp <= 0 -> best
      s -> s |> apply_effects() |> branch_player(spells, best, seen)
    end
  end

  defp step(%State{turn: :boss} = state, best, spells, seen) do
    state
    |> apply_effects()
    |> boss_attack()
    |> Map.put(:turn, :player)
    |> dfs(best, spells, seen)
  end

  defp hard_mode_penalty(%State{mode: :hard} = s),
    do: %{s | player: %{s.player | hp: s.player.hp - 1}}

  defp hard_mode_penalty(s), do: s

  defp branch_player(state, spells, best, seen) do
    spells
    |> Enum.filter(&can_cast?(&1, state))
    |> Enum.reduce(best, fn spell, best_so_far ->
      state
      |> cast(spell)
      |> Map.put(:turn, :boss)
      |> dfs(best_so_far, spells, seen)
    end)
  end

  defp apply_effects(state),
    do: state |> eff_shield() |> eff_poison() |> eff_recharge()

  defp eff_shield(%State{effects: %{shield: n}} = s) when n > 0,
    do: %State{s | effects: %{s.effects | shield: n - 1}, armor: 7}

  defp eff_shield(s), do: %State{s | armor: 0}

  defp eff_poison(%State{effects: %{poison: n}} = s) when n > 0,
    do: %State{s | effects: %{s.effects | poison: n - 1}, boss: %{s.boss | hp: s.boss.hp - 3}}

  defp eff_poison(s), do: s

  defp eff_recharge(%State{effects: %{recharge: n}} = s) when n > 0,
    do: %State{s | effects: %{s.effects | recharge: n - 1}, mana: s.mana + 101}

  defp eff_recharge(s), do: s

  defp boss_attack(%State{boss: %{damage: d}, armor: a, player: p} = s) do
    %State{s | player: %{p | hp: p.hp - max(d - a, 1)}}
  end

  defp can_cast?(%Spell{name: "Shield", cost: c}, %State{mana: m, effects: %{shield: 0}})
       when m >= c,
       do: true

  defp can_cast?(%Spell{name: "Poison", cost: c}, %State{mana: m, effects: %{poison: 0}})
       when m >= c,
       do: true

  defp can_cast?(%Spell{name: "Recharge", cost: c}, %State{mana: m, effects: %{recharge: 0}})
       when m >= c,
       do: true

  defp can_cast?(%Spell{cost: c}, %State{mana: m}) when m >= c, do: true
  defp can_cast?(_, _), do: false

  defp cast(state, %Spell{} = spell) do
    %State{
      state
      | mana: state.mana - spell.cost,
        mana_spent: state.mana_spent + spell.cost,
        boss: %{state.boss | hp: state.boss.hp - spell.damage},
        player: %{state.player | hp: state.player.hp + spell.heal},
        effects: add_effect(state.effects, spell)
    }
  end

  defp add_effect(eff, %Spell{name: "Shield", shield: d}), do: %{eff | shield: d}
  defp add_effect(eff, %Spell{name: "Poison", poison: d}), do: %{eff | poison: d}
  defp add_effect(eff, %Spell{name: "Recharge", mana: d}), do: %{eff | recharge: d}
  defp add_effect(eff, _), do: eff

  defp snapshot(%State{} = s) do
    {s.turn, s.player.hp, s.boss.hp, s.mana, s.armor, s.effects.shield, s.effects.poison,
     s.effects.recharge}
  end
end

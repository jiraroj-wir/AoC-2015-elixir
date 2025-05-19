<p align="center">
  <!-- Replace the path when the tree is complete -->
  <img src="path/to/aoc2015-tree.png" alt="Advent of Code 2015 Tree"/>
</p>

# 🎄 Advent of Code 2015 — in **Elixir**

> *“Ho-ho-hold my pipe operator.”*  

I decided to tackle the classic [Advent of Code 2015](https://adventofcode.com/2015) with a language that treats tuples like royalty, pattern-matches in its sleep, and runs on the indestructible BEAM: **Elixir**. It’s functional, succinct, expressive, and—most importantly—makes me feel clever every time I write `|>`.

---

## ✨ Why Elixir?

* Functional playground (recursion everywhere, side-effects nowhere).  
* Powered by Erlang/OTP — battle-tested for distributed systems and networking.  
* `mix` for painless build & test tooling, `iex` for REPL happiness.  
* Pipes (`|>`) that turn data flow into poetry.

---

## 🧰 Environment

```bash
Erlang/OTP 27 [erts-15.2.7] [64-bit] [smp:8:8] [jit]
Elixir 1.18.3 (compiled with Erlang/OTP 27)
```

Any recent Elixir ≥ 1.18 plus OTP 27 should work fine.

---

## 📁 Project Layout

```
.
├── lib/                # One module per day (Day01, Day02…)
├── priv/inputs/        # My puzzle inputs (yours will differ)
├── stories/            # AI-generated dramatic summaries
├── test/               # Asserted examples straight from AoC
└── mix.exs             # Project configuration
```

Each day’s module contains `part1/0`, `part1/1`, `part2/0`, `part2/1`:

```elixir
iex> AOC2015.Day01.part1()
232  # => Santa’s final floor

iex> AOC2015.Day01.part2()
1783 # => First position that hits the basement
```

---

## 🧪 Running Tests

Tests mirror the official examples—nothing fancy, just *green or red*:

```bash
mix test
```

---

## 📜 Inputs

Puzzle inputs live in `priv/inputs/dayXX.txt`.  
Advent of Code gives each participant a unique file, so swap in yours if you’re comparing answers.

---

## 📚 AI Story Time

Because elves deserve fan-fiction, every solved day gets an **AI-generated, bite-sized, mildly poetic recap** in `stories/`. Imagine Santa starring in a Shakespearian ankle-deep snowdrift.

---

## 📝 My Post-Mortem on Elixir (to be continued…)

> *Thoughts, rants, and “aha!” moments after finishing all 25 days will appear here.*

Meanwhile, you could follow my struggles at [MEMO.md](MEMO.md)

---

## ❌ License

**Unlicense** — public domain. Copy it, fork it, tattoo it on a reindeer.

---

Thanks for dropping by. May your recursion always find a base case, and may the pipes be ever in your favour. 🌟

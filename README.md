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

## 📝 My Post-Mortem on Elixir

Elixir is beautiful — succinct, expressive, and reads almost like pseudocode when you get into the flow with `Enum`, `map`, and `|>`. The language encourages good habits: pure functions, clear flow, and testable components. `Task.async/await` and pattern matching made parallelism and control flow feel natural, not scary.

That said, I’ve only scratched the surface. Advent of Code taught me a lot about Elixir's syntax and idioms, but the real power lies deeper — in the BEAM VM, distributed systems, and the concurrent magic Elixir is known for.

Elixir doesn’t make implementing things easier — quite the opposite sometimes — but once it *works*, and you’ve got full test coverage, you can sleep well knowing it won’t break randomly.

Would I recommend Elixir for AoC or competitive programming? Probably not. But if you want to learn Elixir, then doing something like AoC is a great playground. You'll pick up real intuition fast. The ecosystem (`mix`, docs, tests) supports that kind of exploration really well.

At the end of the day, Elixir is a functional language that encourages immutability, composability, and clean code. It won’t solve the problem for you — but it’ll make you feel clever solving it.

> For deeper thoughts, odd bugs, and Elixir lessons learned, see [MEMO.md](MEMO.md).

---

## ❌ License

**Unlicense** — public domain. Copy it, fork it, tattoo it on a reindeer.

---

Thanks for dropping by. May your recursion always find a base case, and may the pipes be ever in your favour. 🌟

---

<p align="center" style="margin-top: 2rem;">
  <img src="priv/AoC2015_tree.png" alt="Completed AoC2015 Tree" style="width: 100%; max-width: none;">
</p>

<p align="center">
  <!-- Replace with full Advent of Code 2015 tree image -->
  <img src="path/to/aoc2015-tree.png" alt="Advent of Code 2015 Tree"/>
</p>

# 🎄 Advent of Code 2015 — in Elixir

Ho ho huh? It's not December? Who cares.

This is a completely out-of-season dive into [Advent of Code 2015](https://adventofcode.com/2015) using the majestic, tuple-loving, pipe-obsessed, pattern-matching paradise that is **Elixir**.

Elixir feels like what would happen if Erlang and Ruby had a beautiful, functional child who documents its code, writes tests automatically, and runs on BEAM caffeine.

This repo is mostly me poking at functional concepts, appreciating immutability, and occasionally muttering “wow, that's clean” while solving some nerdy elf problems.

---

## 🧰 Environment

```bash
Erlang/OTP 27 [erts-15.2.7] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:1] [jit] [dtrace]
Elixir 1.18.3 (compiled with Erlang/OTP 27)
```

---

## 📁 Project Structure

```bash
.
├── lib/              # Main solution code (one module per day)
├── test/             # Tests based on example cases from AoC site
├── priv/inputs/      # My input.txt files (replace with your own)
├── stories/          # AI-generated summaries of each day’s problem
├── mix.exs           # Standard Elixir project config
└── README.md         # You are here
```

---

## 🧪 Running Tests

This project includes small unit tests based on AoC example data. You can run them all with:

```bash
mix test
```

---

## 📄 Input Files

Each day’s input is stored in `priv/inputs/` as `dayXX.txt`.  
Since AoC gives everyone a unique input, you'll probably need to plug in your own to get your actual solutions.

---

## 📚 Stories

I asked an AI to write short summaries of each problem, and it did.  
They're in `stories/dayXX.md` — light-hearted and slightly dramatic retellings of what the elves are up to.

---

## ❌ License

Unlicensed — do whatever you want with this.  
Fork it, study it, trash it, print it out and fold it into a Christmas ornament. I won’t stop you.

---

<!-- TODO: When finished, update this section to show it's complete -->
<!-- ☑️ AoC 2015 Elixir solutions: COMPLETE! -->
<!-- ❗ WIP – still solving days. Will finalize and polish after Day 25 -->

---

Enjoy the puzzles. Praise the pipes. And may your recursion always find a base case. 🧝‍♂️

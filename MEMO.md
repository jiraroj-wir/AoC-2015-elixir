## Day 4: Traumatised by the Hidden `\n`

### Preface

Functional programming syntax – checked  
No LSP server warnings – checked  
Mix test – check  
Everything went well.

Until...

```elixir
iex()> AOC2015.Day04.part2()
343597
```

```diff
- wrong input, you suck!
```

Shit, this can't be right. It's Elixir — there's no side effects, it passed all test cases without any warnings.  
It wouldn't be as scary if I had coded it in C/C++ or other OOP languages.

---

### What went wrong?

After 15 minutes of hell — felt like I aged a few weeks — I found that there was no problem when I passed the string directly into the function.  
So the problem must be with the `input/1` function that reads `priv/input/day04.txt`.

`File.read!` included a `\n` at the end → invalid hash input.  
I was hashing `"iwrupvqb\n"` instead of `"iwrupvqb"`, and MD5 doesn’t forgive.

---

### Fix

Just trim the string using:

```elixir
String.trim/1
```

And boom — `346386` — AC!

---

### Moral of the story

* Never forget to trim your input strings  
* Or you’ll be ghosted by a newline  
* Literally

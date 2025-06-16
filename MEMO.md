## Day 4: Traumatised by the Hidden `\n`

### Preface

Functional programming syntax – checked  
No LSP server warnings – checked  
`Mix test` – check  
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


---


## Day 14: 9 Deer, 8 Cores — Let’s async It!

### Preface

Read the problem — nine deer, racing in parallel.  
My brain immediately went: **multicore**.  
And with my **M1 chip**?  
Well, seems like a good excuse to finally try some concurrency in Elixir.  
Let’s go.

---

### Process

After reading the task docs from [Hexdocs](https://hexdocs.pm/elixir/1.12/Task.html), I found out I just needed to do:

```elixir
Task.async(fn -> ... end)
Task.await(task)
```

That’s all.  
Not that different from Go’s goroutines, actually.  
Spawn a bunch of workers, wait for results — no fuss.

---

### Theoretical yapping session

Talking about time complexity:

```
Part 1:  O(1)  (kind of, since we parallelize per deer, and there are only 9 deer)
Part 2:  O(n)  where n = race duration (2503 seconds), since we simulate each second
```

So, while it’s not some groundbreaking parallel optimization like:

> “pushing a convolution filter across a 4K image with SIMD on 32 threads,”

…it still gave a nice speed-up.  
And more importantly, it got me thinking about distributed computing in a hands-on way.

---

### My thoughts

I liked it.  
The `Task` module (is that what we call it?) is super approachable and easy to use.

No weird setup.  
No scary boilerplate.  
Just fire off work, collect results.

It gave me real intuition for how to approach **distributed-ish** problems —  
without scaring me off with words like “actor model” or “message passing.”

Elixir made it **painless**, and kind of fun.  
Which is rare for parallel anything.


---


## Day 19: Dark Magic

### Preface

Part 1, nothing hard, feeling like usual.  
Then Part 2...

I realize that the initial approach I used for Part 1 wouldn't work —  
time complexity goes crazily high, like **O(3^300)**.

So, I did the reverse-greedy approach: reversing the replacement key  
and trying to deconstruct the given string into a single `"e"`.  
Then the problem came.

When I ran `mix test`, `part2/1` always returned `nil` and failed the test.  
Took me a while to fix it — then it's ChatGPT's job to fix it.  
Close, but still failed some tests.

Eventually I gave up and just asked for solutions from ChatGPT.  
And it gave me that **dark magic code**.

→ [`lib/day19.ex:52`](lib/day19.ex#L52)

---

### Thoughts

Surprisingly... it works.  
Really well. Probably **O(n)** complexity — which is insane, considering how doomed I felt.

This problem gave me a real look at the "*side effects*" of Elixir —  
not in the traditional sense, but in how sometimes doing things "the normal way"  
just isn't feasible.

---

### Moral of the story

```text
Sometimes you need to rethink the problem.  
Sometimes you need to brute-force cleverly.  
And sometimes… you just accept the wizard’s (ChatGPT’s) dark magic and move on.
```


---


## Day 21 - 22

This mf is nightmare to do: brute force with early exits and other optimization technique ..., lets dont talk about it. 


---


## General thoughts
(aka things I bumped into regularly — maybe call this “Dev Notes” or “Workflow Habits”? idk)

- Regex and string module can be hard at first, but mastering it can help a lot, it turns a dozens of lines of code into a expressive syntax in a single line.
- The trend of myself using the same technique or module that has been proven works: reduce, map, then (for return) and pattern matching. I try new things though, just that most part are done with the same technique.
- Implement higher abstraction or algorithms can be a nightmare, I can imagine how hard it’ll be to implement stuff like Rabin-karp or recursive 0/1 knapsack.
- I kinda get how “let it crash” and immutability shape your problem-solving mindset — you focus more on pipe-style transformations and lean heavily into control flow instead of mutable state.  
- Elixir makes some problems stupidly elegant — and others feel like you're coding Lisp without a debugger.


---


## My thoughts on AoC2015

It was fun at first (day 1 - 15), then a bit challenging around day 15 - 18, and it turns bombastic after that — peak torment on day 22.  
I just feels like AoC supposed to be fun and doable by beginners, and it shouldn't took too much time from you (1 hour? 3 hours? 5 hours a day?).  
When I decide to do sth, I expect to finish it, not just leave it half done.

Day 19 onwards made me wanna quit occasionally, so I decided to just rush the last 5 days of AoC in a single day — to keep my morale high.  
The later days are too demanding for me. With just a college workload, that's nothing compared to people with 9 to 5 jobs.  
And it seems like later years of AoC are getting harder and harder, especially on part 2 that requires a full rewrite.

So, next time I'd be a lot more considerate before starting an AoC.  
It can be fun and you would glide through the first 15 days, but after that — it might cost something more than just your time.


---
